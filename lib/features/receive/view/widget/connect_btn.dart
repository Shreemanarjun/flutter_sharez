import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/receive/controller/connect_pod.dart';
import 'package:flutter_sharez/features/receive/state/connect_btn_state_pod.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

class ConnectBtn extends ConsumerStatefulWidget {
  final SenderModel senderModel;
  const ConnectBtn({
    super.key,
    required this.senderModel,
  });

  @override
  ConsumerState<ConnectBtn> createState() => _ConnectBtnState();
}

class _ConnectBtnState extends ConsumerState<ConnectBtn> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    ref.listen(connectBtnPod(widget.senderModel), (previous, next) {
      if (next is AsyncData) {
        final state = next.value;
        if (state != null && state is ConenctionAcceptanceState) {
          if (state.isAccepted) {
            showInfoSnack(
                child: 'Connection accepted.'.text.isIntrinsic.make());
            ref
                .read(autorouterProvider)
                .navigate(DeviceShareRoute(senderModel: widget.senderModel));
          } else {
            showErrorSnack(
                child: "Connection rejected.".text.isIntrinsic.make());
          }
        }
      }
    });
    final btnstateAsync = ref.watch(connectBtnPod(widget.senderModel));
    return btnstateAsync.easyWhen(
      data: (btnstate) => switch (btnstate) {
        UnconnectedState() => ElevatedButton.icon(
            onPressed: () {
              ref
                  .read(connectBtnPod(widget.senderModel).notifier)
                  .connectToDevice();
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
                ref.read(autorouterProvider).navigate(
                    DeviceShareRoute(senderModel: widget.senderModel));
              } else {
                ref
                    .read(connectBtnPod(widget.senderModel).notifier)
                    .connectToDevice();
              }
            },
            icon: isAccepted
                ? const Icon(Icons.done)
                : const Icon(Icons.subdirectory_arrow_right),
            label: (isAccepted ? "Go to sender" : "Retry").text.make(),
          ),
        ConnectionFailedState() => ElevatedButton.icon(
            onPressed: () {
              ref
                  .read(connectBtnPod(widget.senderModel).notifier)
                  .connectToDevice();
            },
            icon: const Icon(Icons.subdirectory_arrow_right),
            label: "Retry".text.make(),
          ),
      },
    );
  }
}
