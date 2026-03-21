import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';

enum AppThemeAccent {
  midnight(scheme: FlexScheme.deepBlue, name: "Midnight Blue"),
  cyberpunk(scheme: FlexScheme.redWine, name: "Cyberpunk Red"),
  forest(scheme: FlexScheme.greyLaw, name: "Forest Grey"),
  rose(scheme: FlexScheme.sakura, name: "Rose Garden"),
  ocean(scheme: FlexScheme.blue, name: "Ocean Breeze"),
  gold(scheme: FlexScheme.amber, name: "Amber Gold");

  final FlexScheme scheme;
  final String name;
  const AppThemeAccent({required this.scheme, required this.name});
}

final themeAccentPod = NotifierProvider<ThemeAccentNotifier, AppThemeAccent>(
    ThemeAccentNotifier.new);

class ThemeAccentNotifier extends Notifier<AppThemeAccent> {
  static const _key = 'theme_accent';

  @override
  AppThemeAccent build() {
    final storage = ref.read(appStorageProvider);
    final saved = storage.get(key: _key);
    if (saved != null) {
      return AppThemeAccent.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => AppThemeAccent.midnight,
      );
    }
    return AppThemeAccent.midnight;
  }

  void updateTheme(AppThemeAccent accent) {
    state = accent;
    ref.read(appStorageProvider).put(key: _key, value: accent.name);
  }
}

final themeModePod = NotifierProvider<ThemeModeNotifier, ThemeMode>(
    ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final storage = ref.read(appStorageProvider);
    final saved = storage.get(key: _key);
    if (saved != null) {
      return ThemeMode.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => ThemeMode.system,
      );
    }
    return ThemeMode.system;
  }

  void updateMode(ThemeMode mode) {
    state = mode;
    ref.read(appStorageProvider).put(key: _key, value: mode.name);
  }
}
