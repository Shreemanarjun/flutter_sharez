import 'dart:io';
import 'package:dio/dio.dart';

typedef ProgressCallback = void Function(double progress);
typedef CompleteCallback = void Function();

Future<void> downloadFileWithResumeAndProgress({
  required Dio dio,
  required String url,
  required String savePath,
  required CancelToken cancelToken,
  required ProgressCallback onProgress,
  required CompleteCallback onComplete,
}) async {
  final file = File(savePath);

  int receivedBytes = 0;
  if (await file.exists()) {
    receivedBytes = await file.length();
  }

  final response = await dio.head(url);
  final totalBytes =
      int.parse(response.headers.value('content-length') ?? "-1");

  if (receivedBytes < totalBytes) {
    final options = Options(
      headers: {'range': 'bytes=$receivedBytes-$totalBytes'},
    );

    await dio.download(url, savePath,
        options: options,
        cancelToken: cancelToken, onReceiveProgress: (received, total) {
      if (total != -1) {
        double progress = (received + receivedBytes) / total;
        if (progress <= 1) {
          onProgress(progress);
        }
      }
    }, deleteOnError: false);

    onComplete();
  } else {
    onComplete();
  }
}
