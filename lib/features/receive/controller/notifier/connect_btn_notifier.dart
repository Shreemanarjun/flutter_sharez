import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service_pod.dart';
import 'package:flutter_sharez/features/receive/state/connect_btn_state_pod.dart';
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
      final result = await ref.watch(receiverServicePod).connectToDevice(
        ip: arg.ip ?? '127.0.0.1',
        port: arg.port.toString(),
        currentIP: "currentIP",
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
