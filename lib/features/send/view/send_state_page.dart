import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/features/send/view/ui_state/started_server_view.dart';
import 'package:flutter_sharez/features/send/view/ui_state/starting_server_view.dart';

import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SendStatePage extends ConsumerStatefulWidget {
  const SendStatePage({
    super.key,
  });

  @override
  ConsumerState<SendStatePage> createState() => _SendStatePageState();
}

class _SendStatePageState extends ConsumerState<SendStatePage> {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    final sendStateAsync = ref.watch(sendStateNotifierPod);
    return sendStateAsync.easyWhen(
      data: (sendstate) {
        return switch (sendstate) {
          StartingServer() => const StartingServerView(),
          StartedServer(:final serverInfo) => StartedServerView(
              serverInfo: serverInfo,
            ),
          StoppedServer() => t.send_state_server_stopped.text.makeCentered(),
          ServerError(:final error) => error.text.makeCentered().p8(),
        };
      },
    );
  }
}
