import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';

@RoutePage(
  deferredLoading: true,
)
class SendPage extends StatelessWidget {
  const SendPage({super.key});

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
            tooltip: LocaleKeys.actionDownloads.tr(),
          ),
          IconButton(
            onPressed: () {
              context.navigateTo(const SettingsRoute());
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: LocaleKeys.actionSettings.tr(),
          ),
        ],
      ),
      body: const AutoRouter(),
    );
  }
}
