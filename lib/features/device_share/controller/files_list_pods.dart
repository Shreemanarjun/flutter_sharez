import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cancel_extensions.dart';

final senderfileListPod = FutureProvider.autoDispose
    .family<FilePathsModel, SenderModel>((ref, sendermodel) async {
  final result = await ref
      .watch(receiverServicePod(sendermodel))
      .getFilePaths(cancelToken: ref.cancelToken());
  return result.when(
    (filepathsmodel) {
      return filepathsmodel;
    },
    (error) => throw error.message,
  );
});
