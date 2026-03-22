import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:flutter_sharez/data/service/receive/push_receiver_service.dart';
import 'package:flutter_sharez/features/receive/state/connect_btn_state_pod.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';

class ConnectBtnNotifier extends AsyncNotifier<ConnectBtnState> {
  final SenderModel arg;
  ConnectBtnNotifier(this.arg);
  @override
  FutureOr<ConnectBtnState> build() {
    return UnconnectedState();
  }

  Future<void> connectToDevice() async {
    state = AsyncData(ConnectingState());
    state = await AsyncValue.guard(() async {
      final dioCT = CancelToken();
      final storage = ref.read(appStorageProvider);
      final uuid = storage.get(key: 'device_uuid') ?? '';
      final ipRes = await getAllIPs();
      final myIp = ipRes.when((success) => success.first, (error) => '');

      final localPort = ref.read(pushReceiverProvider).port ?? 0;
      final result = await ref.watch(receiverServicePod).connectToDevice(
            ip: arg.ip,
            port: arg.port.toString(),
            currentIP: myIp,
            localPort: localPort,
            deviceUUID: uuid,
            cancelToken: dioCT,
          );
      return result.when((isAccepted) {
        ref.keepAlive();
        return ConenctionAcceptanceState(isAccepted: isAccepted);
      }, (error) {
        return ConnectionFailedState(message: error.message);
      });
    });
  }
}
