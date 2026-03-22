import 'dart:io';
import 'package:dio/dio.dart';

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
  final dio = Dio();

  int receivedBytes = 0;
  if (await file.exists()) {
    receivedBytes = await file.length();
  }

  // Get total file size using HEAD request
  final headResponse = await dio.head(url);
  final totalBytesStr = headResponse.headers.value(HttpHeaders.contentLengthHeader) ?? '-1';
  final totalBytes = int.parse(totalBytesStr);

  if (receivedBytes < totalBytes || totalBytes == -1) {
    final response = await dio.get<ResponseBody>(
      url,
      options: Options(
        responseType: ResponseType.stream,
        headers: {HttpHeaders.rangeHeader: 'bytes=$receivedBytes-'},
      ),
      cancelToken: cancelToken,
    );

    final stream = response.data!.stream;
    final sink = file.openWrite(
        mode: receivedBytes > 0 ? FileMode.append : FileMode.write);

    int currentReceived = receivedBytes;

    try {
      await for (final chunk in stream) {
        sink.add(chunk);
        currentReceived += chunk.length;

        if (totalBytes != -1) {
          double progress = currentReceived / totalBytes;
          if (progress <= 1) {
            onProgress(progress);
          }
        }
      }
      await sink.close();
      onComplete();
    } catch (e) {
      await sink.close();
      rethrow;
    }
  } else {
    onComplete();
  }
}
