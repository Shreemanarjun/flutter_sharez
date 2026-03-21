import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:rhttp/rhttp.dart' as rhttp;

final senderfileListPod = FutureProvider.autoDispose
    .family<FilePathsModel, SenderModel>((ref, sendermodel) async {
  final rhttpCT = rhttp.CancelToken();
  ref.onDispose(() {
    rhttpCT.cancel();
  });

  final result = await ref.watch(receiverServicePod).getFilePaths(
        ip: sendermodel.ip ?? '127.0.0.1',
        port: sendermodel.port.toString(),
        cancelToken: rhttpCT,
      );

  return result.when(
    (filepathsmodel) {
      return filepathsmodel;
    },
    (error) {
      throw error;
    },
  );
});
