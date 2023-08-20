import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/state/file_download_state.dart';
import 'package:flutter_sharez/shared/api_client/dio/default_time_response_interceptor.dart';

import 'package:flutter_sharez/shared/helper/range_downloader.dart';

import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class FileDownloaderNotifier
    extends AutoDisposeFamilyAsyncNotifier<DownloadState, FilePath> {
  CancelToken _cancelToken = CancelToken();
  final _dio = Dio();
  Future<String> getSavePath() async {
    final path = ((await getDownloadsDirectory())?.path) ??
        ((await getExternalStorageDirectory())?.path) ??
        ((await getTemporaryDirectory()).path);
    return '$path/${arg.file.name}';
  }

  String get _url => "http://${arg.link}";

  @override
  FutureOr<DownloadState> build(FilePath arg) {
    if (kDebugMode) {
      _dio.interceptors.add(TimeResponseInterceptor());
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }
    return DownloadState.initial();
  }

  Future<void> startDownload() async {
    _cancelToken = CancelToken();
    try {
      state = AsyncData(DownloadState.downloading());
      await downloadFileWithResumeAndProgress(
        dio: _dio,
        cancelToken: _cancelToken,
        url: _url,
        savePath: await getSavePath(),
        onProgress: (progress) {
          talker.debug(progress);
          final currentState = state.value;
          if (currentState != null) {
            state = AsyncData(currentState.copyWith(progress: progress));
          }
        },
        onComplete: () {
          state = AsyncData(DownloadState.completed());
        },
      );
    } catch (e) {
      talker.error("Error downloading file: $e");
    }
  }

  void cancelDownload() {
    _cancelToken.cancel("Download canceled");

    state = AsyncData(DownloadState.initial());
  }

  void pauseDownload() {
    _cancelToken.cancel("Download paused");

    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isPaused: true));
    }
  }

  Future<void> resumeDownload() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isPaused: false));
    }

    await startDownload();
  }

  void resetDownload() {
    state = AsyncData(DownloadState.initial());
  }

  void openFile() async {
    final path = await getSavePath();
    if (await File(path).exists()) {
      OpenAppFile.open(
        path,
        locate: true,
      );
    } else {
      startDownload();
    }
  }
}
