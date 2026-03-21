import 'dart:convert';
import 'dart:io';

import 'package:flutter_sharez/data/model/check_server_model.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rhttp/rhttp.dart';

class ReceiverService {
  ReceiverService();

  Future<Result<bool, BaseException>> connectToDevice({
    required String ip,
    required String port,
    required currentIP,
    required String deviceUUID,
    required CancelToken cancelToken,
  }) async {
    try {
      final receiverModel = ReceiverModel(
        ip: currentIP,
        port: 8080,
        host: Platform.localHostname,
        os: Platform.operatingSystem,
        version: Platform.operatingSystemVersion,
        deviceUUID: deviceUUID,
      );

      final response = await Rhttp.post(
        'http://$ip:$port/checkServer',
        body: HttpBody.json(
          receiverModel.toMap(),
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final checkServermodel =
            CheckServerModel.fromMap(jsonDecode(response.body));
        if (checkServermodel.message.contains('Accepted')) {
          return const Success(true);
        } else {
          return const Success(false);
        }
      } else {
        final checkServermodel =
            CheckServerModel.fromMap(jsonDecode(response.body));
        return Error(BaseException(message: checkServermodel.message));
      }
    } catch (e) {
      if (e is RhttpException) {
        if (e is RhttpCancelException) {
          return Error(BaseException(message: "Connection cancelled"));
        }
      }
      return Error(BaseException(message: e.toString()));
    }
  }

  Future<Result<FilePathsModel, BaseException>> getFilePaths({
    required String ip,
    required String port,
    required CancelToken cancelToken,
  }) async {
    try {
      final response = await Rhttp.get(
        'http://$ip:$port/filepath',
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        return Success(
          FilePathsModel.fromMap(jsonDecode(response.body)),
        );
      } else {
        return Error(
          BaseException(message: "Failed to get files"),
        );
      }
    } catch (e) {
      return Error(BaseException(message: e.toString()));
    }
  }
}
