import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';

@RoutePage(
  deferredLoading: true,
)
class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appActions: [
          IconButton(
            onPressed: () {
              context.navigateTo(const DownloadsRoute());
            },
            icon: const Icon(
              Icons.download_outlined,
            ),
            tooltip: 'Downloads',
          ),
          IconButton(
            onPressed: () {
              context.navigateTo(const SettingsRoute());
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'App Settings',
          ),
        ],
      ),
      body: const AutoRouter(),
    );
  }
}
