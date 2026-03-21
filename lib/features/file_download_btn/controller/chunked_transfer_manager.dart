import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:rhttp/rhttp.dart';

class ChunkedTransferManager {
  final String url;
  final String savePath;
  final int fileSize;
  final int parallelChunks;

  ChunkedTransferManager({
    required this.url,
    required this.savePath,
    required this.fileSize,
    this.parallelChunks = 4,
  });

  List<CancelToken> _cancelTokens = [];
  bool _isCancelled = false;
  bool _isPaused = false;

  int _downloadedBytes = 0;
  final Map<int, int> _chunkProgress = {};
  DateTime _startTime = DateTime.now();

  Future<void> start({
    required Function(double progress, double speed, int remainTimeSec)
        onProgress,
    required Function() onMergeStart,
    required Function(bool success, String? hash) onComplete,
    required Function(String error) onError,
  }) async {
    _isCancelled = false;
    _isPaused = false;
    _cancelTokens = List.generate(parallelChunks, (_) => CancelToken());
    _startTime = DateTime.now();
    _downloadedBytes = 0;
    _chunkProgress.clear();

    final int chunkSize = (fileSize / parallelChunks).ceil();
    final List<Future<void>> futures = [];

    for (int i = 0; i < parallelChunks; i++) {
      _chunkProgress[i] = 0;
      final int startByte = i * chunkSize;
      final int endByte = (i == parallelChunks - 1)
          ? fileSize - 1
          : (startByte + chunkSize - 1);

      futures.add(_downloadChunk(i, startByte, endByte, onProgress, onError));
    }

    try {
      await Future.wait(futures);
      if (_isCancelled || _isPaused) return;

      onMergeStart();
      final result = await _stitchAndVerifyAsynchronously();
      if (result.success) {
        onComplete(true, result.hash);
      } else {
        onError("Merging failed or file size mismatch.");
      }
    } catch (e) {
      if (!_isCancelled && !_isPaused) {
        onError("Transfer failed: $e");
      }
    }
  }

  Future<void> _downloadChunk(
    int chunkIndex,
    int startByte,
    int endByte,
    Function(double progress, double speed, int remainTimeSec) onProgress,
    Function(String error) onError,
  ) async {
    final String partPath = '$savePath.part$chunkIndex';
    final File partFile = File(partPath);

    int received = 0;
    if (await partFile.exists()) {
      received = await partFile.length();
      _chunkProgress[chunkIndex] = received;
      _downloadedBytes += received;
    }

    if (received >= (endByte - startByte + 1)) {
      return; // Already finished this chunk
    }

    final int currentStartByte = startByte + received;

    try {
      final res = await Rhttp.getStream(
        url,
        headers: HttpHeaders.map(
            {HttpHeaderName.range: 'bytes=$currentStartByte-$endByte'}),
        cancelToken: _cancelTokens[chunkIndex],
      );

      final stream = res.body;
      final sink = partFile.openWrite(mode: FileMode.append);

      await for (final chunk in stream) {
        if (_isCancelled || _isPaused) {
          await sink.close();
          return;
        }

        sink.add(chunk);
        received += chunk.length;
        _chunkProgress[chunkIndex] = received;
        _downloadedBytes += chunk.length;

        _reportProgress(onProgress);
      }

      await sink.close();
    } catch (e) {
      if (e is RhttpCancelException) return;
      onError("Chunk $chunkIndex error: $e");
      rethrow;
    }
  }

  void _reportProgress(
      Function(double progress, double speed, int remainTimeSec) onProgress) {
    if (fileSize == 0) return;

    final double progress = _downloadedBytes / fileSize;
    final Duration elapsed = DateTime.now().difference(_startTime);
    final double elapsedSec = elapsed.inMilliseconds / 1000.0;

    double speed = 0.0;
    if (elapsedSec > 0) {
      speed = _downloadedBytes / elapsedSec; // bytes per second
    }

    int remainTimeSec = 0;
    if (speed > 0) {
      remainTimeSec = ((fileSize - _downloadedBytes) / speed).ceil();
    }

    onProgress(progress, speed, remainTimeSec);
  }

  void pause() {
    _isPaused = true;
    for (var token in _cancelTokens) {
      token.cancel();
    }
  }

  void cancel() {
    _isCancelled = true;
    for (var token in _cancelTokens) {
      token.cancel();
    }
    // Clean up temp files
    for (int i = 0; i < parallelChunks; i++) {
      final file = File('$savePath.part$i');
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }

  Future<({bool success, String? hash})> _stitchAndVerifyAsynchronously() async {
    final path = savePath;
    final chunks = parallelChunks;
    final expectedSize = fileSize;

    return await Isolate.run(() async {
      try {
        final finalFile = File(path);
        if (finalFile.existsSync()) finalFile.deleteSync();

        final sink = finalFile.openWrite();
        for (int i = 0; i < chunks; i++) {
          final partFile = File('$path.part$i');
          if (!partFile.existsSync()) return (success: false, hash: null);

          await sink.addStream(partFile.openRead());
          partFile.deleteSync();
        }
        await sink.close();

        // Verification phase
        final verifyFile = File(path);
        final int finalSize = await verifyFile.length();
        if (finalSize != expectedSize) {
          return (success: false, hash: null);
        }

        // Calculate SHA-256 for corruption check/logging
        final input = verifyFile.openRead();
        final sha = await sha256.bind(input).first;
        final hashString = sha.toString();

        return (success: true, hash: hashString);
      } catch (e) {
        return (success: false, hash: null);
      }
    });
  }
}
