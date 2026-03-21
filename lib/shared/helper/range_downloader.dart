import 'dart:io';
import 'package:rhttp/rhttp.dart';

typedef ProgressCallback = void Function(double progress);
typedef CompleteCallback = void Function();

Future<void> downloadFileWithResumeAndProgress({
  required String url,
  required String savePath,
  required CancelToken cancelToken,
  required ProgressCallback onProgress,
  required CompleteCallback onComplete,
}) async {
  final file = File(savePath);

  double receivedBytes = 0;
  if (await file.exists()) {
    receivedBytes = (await file.length()).toDouble();
  }

  final headResponse = await Rhttp.head(url);
  final contentLengthStr = headResponse.headers.where((e) => e.$1 == 'content-length').firstOrNull?.$2 ?? '-1';
  final totalBytes = double.parse(contentLengthStr);

  if (receivedBytes < totalBytes || totalBytes == -1) {
    final streamResponse = await Rhttp.getStream(
      url,
      headers: HttpHeaders.map({
        HttpHeaderName.range: 'bytes=${receivedBytes.toInt()}-'
      }),
      cancelToken: cancelToken,
    );

    final stream = streamResponse.body;
    final sink = file.openWrite(mode: receivedBytes > 0 ? FileMode.append : FileMode.write);

    int currentReceived = receivedBytes.toInt();

    final subscription = stream.listen((chunk) {
      sink.add(chunk);
      currentReceived += chunk.length;

      if (totalBytes != -1) {
        double progress = currentReceived / totalBytes;
        if (progress <= 1) {
          onProgress(progress);
        }
      }
    });

    await subscription.asFuture();
    await sink.close();

    onComplete();
  } else {
    onComplete();
  }
}
