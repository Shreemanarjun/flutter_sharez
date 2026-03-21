import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/state/file_download_state.dart';

import 'package:flutter_sharez/features/file_download_btn/controller/chunked_transfer_manager.dart';
import 'package:flutter_sharez/data/model/download_item.dart';
import 'package:flutter_sharez/features/downloads/controller/download_history_pod.dart';
import 'package:flutter_sharez/features/settings/controller/settings_pod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_info/platform_info.dart' as pinfo;

class FileDownloaderNotifier extends AsyncNotifier<DownloadState> {
  final FilePath arg;
  FileDownloaderNotifier(this.arg);
  ChunkedTransferManager? _manager;

  Future<Directory> defaultDirectory() async {
    final customPath = ref.read(downloadPathProvider);
    if (customPath != null) {
      final dir = Directory(customPath);
      if (await dir.exists()) return dir;
    }
    var directory = await pinfo.Platform.I.when(
      android: () async {
        var temp = Directory('/storage/emulated/0/Download/');
        (await temp.exists()) ? temp : await getApplicationDocumentsDirectory();
        return temp;
      },
      iOS: () async => await getApplicationDocumentsDirectory(),
      desktop: () async => await getDownloadsDirectory(),
      orElse: () async => await getTemporaryDirectory(),
    );
    return directory ?? Directory('/');
  }

  Future<String> getSavePath() async {
    final Directory directory = await defaultDirectory();
    return '${directory.path}${Platform.pathSeparator}${arg.file.name}';
  }

  String get _url => "http://${arg.link}";

  @override
  FutureOr<DownloadState> build() {
    ref.keepAlive();
    return DownloadState.initial();
  }

  Future<void> startDownload() async {
    try {
      state = AsyncData(
        DownloadState.downloading(
          progress: Progress(
            currentProgress: 0,
            remainTime: 0,
            speed: 0,
          ),
          isPaused: false,
        ),
      );

      final int processors = pinfo.Platform.I.numberOfProcessors;
      final int concurrency = (processors > 1) ? processors - 1 : 1;

      _manager = ChunkedTransferManager(
        url: _url,
        savePath: await getSavePath(),
        fileSize: arg.file.size,
        parallelChunks: concurrency > 4
            ? 4
            : concurrency, // Limit to 4 parallel HTTP chunks max
      );

      await _manager!.start(
        onProgress: (progress, speed, remainTime) {
          final currentState = state.value;
          if (currentState != null) {
            state = AsyncData(
              DownloadState.downloading(
                progress: Progress(
                  currentProgress: progress,
                  speed: speed,
                  remainTime: remainTime.toDouble(),
                ),
                isPaused: false,
              ),
            );
          }
        },
        onMergeStart: () {
          state = AsyncData(DownloadState.mergeDone(isCompleted: false));
        },
        onComplete: (success, hash) async {
          if (success) {
            talker.info("Transfer completed. SHA-256: $hash");
            final savePath = await getSavePath();
            ref.read(downloadHistoryPod.notifier).addDownload(
                  DownloadItem(
                    name: arg.file.name,
                    size: arg.file.size,
                    path: savePath,
                    downloadDate: DateTime.now(),
                    isCompleted: true,
                  ),
                );
            state = AsyncData(DownloadState.completed());
          } else {
            state = AsyncData(DownloadState.error());
          }
        },
        onError: (err) {
          talker.error("Transfer error: $err");
          state = AsyncData(DownloadState.error());
        },
      );
    } catch (e) {
      talker.error("Error downloading file: $e");
      state = AsyncData(DownloadState.error());
    }
  }

  void cancelDownload() {
    _manager?.cancel();
    state = AsyncData(DownloadState.initial());
  }

  void pauseDownload() {
    _manager?.pause();
    final currentState = state.value;
    if (currentState != null && currentState is DownloadingState) {
      state = AsyncData(currentState.copyWith(isPaused: true));
    }
  }

  Future<void> resumeDownload() async {
    final currentState = state.value;
    if (currentState != null && currentState is DownloadingState) {
      state = AsyncData(currentState.copyWith(isPaused: false));
    }
    await startDownload();
  }

  void resetDownload() async {
    _manager?.cancel();
    state = AsyncData(DownloadState.initial());
    await startDownload();
  }

  void openFile() async {
    final path = utf8.decode(
      (await getSavePath()).codeUnits,
      allowMalformed: true,
    );
    if (await File(path).exists()) {
      final result = await OpenFilex.open(path);
      if (result.type == ResultType.error) {
        await OpenFilex.open((await defaultDirectory()).path);
      }
    } else {
      startDownload();
    }
  }
}
