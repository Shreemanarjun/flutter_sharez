import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        appActions: [
          ShadTooltip(
            builder: (context) => const Text('Downloads'),
            child: ShadButton.ghost(
              child: const Icon(LucideIcons.download),
              onPressed: () {
                context.navigateTo(const DownloadsRoute());
              },
            ),
          ),
          ShadTooltip(
            builder: (context) => const Text('App Settings'),
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
