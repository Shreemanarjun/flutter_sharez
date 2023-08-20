import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_sharez/data/model/check_server_model.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

class ReceiverService {
  final Dio dio;

  ReceiverService({required this.dio});

  Future<Result<bool, BaseException>> connectToDevice({
    required String ip,
    required String port,
    required currentIP,
    required CancelToken cancelToken,
  }) async {
    final response = await dio.post(
      '/checkServer',
      data: ReceiverModel(
        ip: currentIP,
        port: 8080,
        host: Platform.localHostname,
        os: Platform.operatingSystem,
        version: Platform.operatingSystemVersion,
      ).toMap(),
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      final checkServermodel = CheckServerModel.fromMap(response.data);
      if (checkServermodel.message.contains('Accepted')) {
        return const Success(true);
      } else {
        return const Success(false);
      }
    } else {
      try {
        final checkServermodel = CheckServerModel.fromMap(response.data);
        return Error(BaseException(message: checkServermodel.message));
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    }
  }

  Future<Result<FilePathsModel, BaseException>> getFilePaths({
    required CancelToken cancelToken,
  }) async {
    final response = await dio.get(
      '/filepath',
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return Success(
        FilePathsModel.fromMap(response.data),
      );
    } else {
      return Error(
        BaseException(message: "Failed to get files"),
      );
    }
  }
}
