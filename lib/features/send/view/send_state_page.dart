import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/features/send/view/ui_state/started_server_view.dart';
import 'package:flutter_sharez/features/send/view/ui_state/starting_server_view.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_sharez/core/is_golden_test_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
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
          StoppedServer() => Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ShadCard(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/anim/scanning.json',
                        height: 200,
                        repeat: !ref.watch(isGoldenTestProvider),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.sendStateServerStopped,
                        style: ShadTheme.of(context).textTheme.h2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Your local portal is currently offline. Other devices won't be able to discover or download files.",
                        style: ShadTheme.of(context).textTheme.muted,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ShadButton(
                          size: ShadButtonSize.lg,
                          onPressed: () {
                            ref
                                .read(sendStateNotifierPod.notifier)
                                .startServer();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.play, size: 20),
                              SizedBox(width: 12),
                              Text("Start Server",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ServerError(:final error) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(error)),
            ),
        };
      },
    );
  }
}
