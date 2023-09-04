import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_sharez/features/settings/view/widget/about_app_tile.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.l10n.settingsPage.text.make(),
      ),
      bottomSheet: const AboutAppTile().py24(),
      body: Column(
        children: [
          ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: [
              ListTile(
                title: context.l10n.changeLanguage.text.bold.make(),
                trailing: const AppLocalePopUp(),
              ),
              ListTile(
                title: context.l10n.switchTheme.text.bold.make(),
                trailing: const ThemeSegmentedBtn(),
              ),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
