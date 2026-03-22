import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:rhttp/rhttp.dart' as rhttp;
import 'package:web_socket_channel/web_socket_channel.dart';

final senderfileListPod = FutureProvider.autoDispose
    .family<FilePathsModel, SenderModel>((ref, sendermodel) async {
  final rhttpCT = rhttp.CancelToken();
  final wsUrl = 'ws://${sendermodel.ip}:${sendermodel.port}/ws';
  final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

  ref.onDispose(() {
    rhttpCT.cancel();
    channel.sink.close();
  });

  // Listen for updates from the sender
  channel.stream.listen((event) {
    talker.debug("Received event from sender: $event");
    final data = jsonDecode(event);
    if (data['type'] == 'update') {
      ref.invalidateSelf();
    }
  }, onError: (e) {
    talker.error("WebSocket error: $e");
  });

  final result = await ref.watch(receiverServicePod).getFilePaths(
        ip: sendermodel.ip,
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
