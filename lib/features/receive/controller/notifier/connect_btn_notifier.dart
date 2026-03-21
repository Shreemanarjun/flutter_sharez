import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:flutter_sharez/features/receive/state/connect_btn_state_pod.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';
import 'package:rhttp/rhttp.dart' as rhttp;

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
      final rhttpCT = rhttp.CancelToken();
      final storage = ref.read(appStorageProvider);
      final uuid = storage.get(key: 'device_uuid') ?? '';
      final ipRes = await getAllIPs();
      final myIp = ipRes.when((success) => success.first, (error) => '');

      // The provided edit for this section is syntactically incorrect and incomplete.
      // Assuming the intent was to pass the existing 'arg' (SenderModel) properties
      // to the connectToDevice method, or to create a ReceiverModel from it.
      // Since the instruction is to make the change faithfully and syntactically correct,
      // and the provided snippet is broken, I will apply the imports and
      // keep the existing functional call to connectToDevice, as the provided
      // snippet for this part cannot be integrated correctly without further context
      // or correction.
      final result = await ref.watch(receiverServicePod).connectToDevice(
            ip: arg.ip,
            port: arg.port.toString(),
            currentIP: myIp,
            deviceUUID: uuid,
            cancelToken: rhttpCT,
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
