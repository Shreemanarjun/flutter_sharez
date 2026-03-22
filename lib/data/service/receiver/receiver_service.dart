import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/check_server_model.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

/// [ReceiverService] handles outgoing HTTP requests to other devices (Senders).
/// It uses [Dio] for high performance and reliability in peer-to-peer file transfers.
class ReceiverService {
  final Ref _ref;
  ReceiverService(this._ref);

  /// Establishes a connection with a sender by sending this device's metadata.
  /// 
  /// Returns [Success(true)] if the sender accepts the connection request.
  /// The sender may show a confirmation dialog before accepting.
  Future<Result<bool, BaseException>> connectToDevice({
    required String ip,
    required String port,
    required String currentIP,
    required int localPort,
    required String deviceUUID,
    required CancelToken cancelToken,
  }) async {
    try {
      final receiverModel = ReceiverModel(
        ip: currentIP,
        port: localPort,
        host: Platform.localHostname,
        os: Platform.operatingSystem,
        version: Platform.operatingSystemVersion,
        deviceUUID: deviceUUID,
      );

      final dio = _ref.read(dioProvider('http://$ip:$port'));
      final response = await dio.post(
        '/checkServer',
        data: receiverModel.toMap(),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final checkServermodel =
            CheckServerModel.fromMap(response.data);
        if (checkServermodel.message.contains('Accepted')) {
          return const Success(true);
        } else {
          return const Success(false);
        }
      } else {
        final checkServermodel =
            CheckServerModel.fromMap(response.data);
        return Error(BaseException(message: checkServermodel.message));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.cancel) {
          return Error(BaseException(message: "Connection cancelled"));
        }
        return Error(BaseException(message: e.message ?? e.toString()));
      }
      return Error(BaseException(message: e.toString()));
    }
  }

  /// Fetches the list of shared files from a sender device.
  /// 
  /// Returns a [FilePathsModel] containing descriptions and download links
  /// for all files currently being shared by the sender.
  Future<Result<FilePathsModel, BaseException>> getFilePaths({
    required String ip,
    required String port,
    required CancelToken cancelToken,
  }) async {
    try {
      final dio = _ref.read(dioProvider('http://$ip:$port'));
      final response = await dio.get(
        '/filepath',
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final model = FilePathsModel.fromMap(response.data);
        // Ensure links are absolute by prepending original host/port if they are paths.
        final updatedPaths = model.paths.map((path) {
          if (path.link.startsWith('/')) {
            return path.copyWith(link: "$ip:$port${path.link}");
          }
          return path;
        }).toList();
        return Success(model.copyWith(paths: updatedPaths));
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
