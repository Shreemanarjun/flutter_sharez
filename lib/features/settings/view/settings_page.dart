import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_sharez/features/settings/view/widget/about_app_tile.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settingsPage),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomSheet(
          onClosing: () {},
          builder: (context) => const AboutAppTile(),
          enableDrag: false,
          showDragHandle: false,
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: Text(
              t.changeLanguage,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const AppLocalePopUp(),
          ),
          ListTile(
            title: Text(
              t.switchTheme,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const ThemeSegmentedBtn(),
          ),
        ],
      ),
    );
  }
}
