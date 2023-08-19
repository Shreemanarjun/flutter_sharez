import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/receive/controller/connect_pod.dart';
import 'package:flutter_sharez/features/receive/state/connect_btn_state_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

class ConnectBtn extends ConsumerWidget {
  final SenderModel senderModel;
  const ConnectBtn({
    Key? key,
    required this.senderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final btnstateAsync = ref.watch(connectBtnPod(senderModel));
    return btnstateAsync.easyWhen(
      data: (btnstate) => switch (btnstate) {
        UnconnectedState() => ElevatedButton.icon(
            onPressed: () {
              ref.read(connectBtnPod(senderModel).notifier).connectToDevice();
            },
            icon: const Icon(Icons.subdirectory_arrow_right),
            label: "Connect".text.make(),
          ),
        ConnectingState() => const ElevatedButton(
            onPressed: null,
            child: CircularProgressIndicator.adaptive(),
          ),
        ConenctionAcceptanceState(:final isAccepted) => ElevatedButton.icon(
            onPressed: () {
              if (isAccepted) {
                /// Go to device page directly
              } else {
                ref.read(connectBtnPod(senderModel).notifier).connectToDevice();
              }
            },
            icon: isAccepted
                ? const Icon(Icons.done)
                : const Icon(Icons.subdirectory_arrow_right),
            label: (isAccepted ? "Go to device" : "Retry").text.make(),
          ),
        ConnectionFailedState() => ElevatedButton.icon(
            onPressed: () {
              ref.read(connectBtnPod(senderModel).notifier).connectToDevice();
            },
            icon: const Icon(Icons.subdirectory_arrow_right),
            label: "Retry".text.make(),
          ),
      },
    );
  }
}
