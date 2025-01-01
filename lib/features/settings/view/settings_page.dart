import 'package:auto_route/annotations.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_sharez/features/settings/view/widget/about_app_tile.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.t.settingsPage.text.make(),
      ),
      bottomNavigationBar: BottomSheet(
        onClosing: () {},
        builder: (context) => const AboutAppTile(),
        enableDrag: false,
        showDragHandle: false,
      ).safeArea(),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: context.t.changeLanguage.text.bold.make(),
            trailing: const AppLocalePopUp(),
          ),
          ListTile(
            title: context.t.switchTheme.text.bold.make(),
            trailing: const ThemeSegmentedBtn(),
          ),
        ],
      ),
    );
  }
}
