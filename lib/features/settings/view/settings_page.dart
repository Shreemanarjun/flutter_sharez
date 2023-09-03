import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Settings'.text.make(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: "Change Language".text.bold.make(),
            trailing: AppLocalePopUp(),
          ),
          ListTile(
            title: "Switch Theme".text.bold.make(),
            trailing: const ThemeSegmentedBtn(),
          ),
        ],
      ),
    );
  }
}
