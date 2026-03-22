import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SendPage extends ConsumerWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return Scaffold(
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        appActions: [
          ShadTooltip(
            builder: (context) => Text(t.actionDownloads),
            child: ShadButton.ghost(
              child: const Icon(LucideIcons.download),
              onPressed: () {
                context.navigateTo(const DownloadsRoute());
              },
            ),
          ),
          ShadTooltip(
            builder: (context) => Text(t.actionSettings),
            child: ShadButton.ghost(
              child: const Icon(LucideIcons.settings),
              onPressed: () {
                context.navigateTo(const SettingsRoute());
              },
            ),
          ),
        ],
      ),
      body: const AutoRouter(),
    );
  }
}
