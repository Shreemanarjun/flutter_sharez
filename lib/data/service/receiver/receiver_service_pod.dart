import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';

final receiverServicePod =
    Provider.autoDispose.family<ReceiverService, SenderModel>(
  (ref, sendermodel) {
    return ReceiverService(
      dio: ref.watch(
        dioProvider('http://${sendermodel.ip}:${sendermodel.port}'),
      ),
    );
  },
  name: 'receiverServicePod',
);
