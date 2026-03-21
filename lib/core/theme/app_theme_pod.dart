import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppThemeAccent {
  midnight(
      scheme: FlexScheme.deepBlue, name: "Midnight Blue", color: Colors.indigo),
  cyberpunk(
      scheme: FlexScheme.redWine, name: "Cyberpunk Red", color: Colors.red),
  forest(
      scheme: FlexScheme.greyLaw, name: "Forest Grey", color: Colors.blueGrey),
  rose(scheme: FlexScheme.sakura, name: "Rose Garden", color: Colors.pink),
  ocean(scheme: FlexScheme.blue, name: "Ocean Breeze", color: Colors.blue),
  gold(scheme: FlexScheme.amber, name: "Amber Gold", color: Colors.amber),
  purple(
      scheme: FlexScheme.purpleM3, name: "Gothic Purple", color: Colors.purple),
  wasabi(scheme: FlexScheme.wasabi, name: "Wasabi Green", color: Colors.green),
  orange(
      scheme: FlexScheme.orangeM3, name: "Flame Orange", color: Colors.orange),
  vesuvius(
      scheme: FlexScheme.vesuviusBurn,
      name: "Vesuvius Burn",
      color: Colors.brown),
  bluish(
      scheme: FlexScheme.brandBlue,
      name: "Brand Blue",
      color: Color(0xFF3B5998)),
  mallard(
      scheme: FlexScheme.mallardGreen,
      name: "Mallard Green",
      color: Color(0xFF006400)),
  custom(scheme: FlexScheme.custom, name: "Custom Color", color: Colors.blue);

  final FlexScheme scheme;
  final String name;
  final Color color;
  const AppThemeAccent(
      {required this.scheme, required this.name, required this.color});
}

class ThemeAccentState {
  final AppThemeAccent accent;
  final Color? customColor;

  ThemeAccentState({required this.accent, this.customColor});

  Color get activeColor =>
      (accent == AppThemeAccent.custom ? customColor : accent.color) ??
      accent.color;

  ColorScheme getScheme(Brightness brightness) {
    return SeedColorScheme.fromSeeds(
      brightness: brightness,
      primaryKey: activeColor,
      tones: FlexTones.vivid(brightness),
    );
  }

  ShadThemeData getShadTheme(Brightness brightness) {
    // We map each accent to a predefined Shadcn scheme that feels similar.
    // If not matching perfectly, we use Blue or Slate as base.
    ShadColorScheme colorScheme;
    if (brightness == Brightness.light) {
      colorScheme = switch (accent) {
        AppThemeAccent.midnight => ShadBlueColorScheme.light(),
        AppThemeAccent.cyberpunk => ShadRedColorScheme.light(),
        AppThemeAccent.forest => ShadSlateColorScheme.light(),
        AppThemeAccent.rose => ShadRoseColorScheme.light(),
        AppThemeAccent.ocean => ShadBlueColorScheme.light(),
        AppThemeAccent.gold => ShadYellowColorScheme.light(),
        AppThemeAccent.purple => ShadVioletColorScheme.light(),
        AppThemeAccent.wasabi => ShadGreenColorScheme.light(),
        AppThemeAccent.orange => ShadOrangeColorScheme.light(),
        AppThemeAccent.vesuvius => ShadSlateColorScheme.light(),
        AppThemeAccent.bluish => ShadBlueColorScheme.light(),
        AppThemeAccent.mallard => ShadGreenColorScheme.light(),
        AppThemeAccent.custom => ShadBlueColorScheme.light(),
      };
    } else {
      colorScheme = switch (accent) {
        AppThemeAccent.midnight => ShadBlueColorScheme.dark(),
        AppThemeAccent.cyberpunk => ShadRedColorScheme.dark(),
        AppThemeAccent.forest => ShadSlateColorScheme.dark(),
        AppThemeAccent.rose => ShadRoseColorScheme.dark(),
        AppThemeAccent.ocean => ShadBlueColorScheme.dark(),
        AppThemeAccent.gold => ShadYellowColorScheme.dark(),
        AppThemeAccent.purple => ShadVioletColorScheme.dark(),
        AppThemeAccent.wasabi => ShadGreenColorScheme.dark(),
        AppThemeAccent.orange => ShadOrangeColorScheme.dark(),
        AppThemeAccent.vesuvius => ShadSlateColorScheme.dark(),
        AppThemeAccent.bluish => ShadBlueColorScheme.dark(),
        AppThemeAccent.mallard => ShadGreenColorScheme.dark(),
        AppThemeAccent.custom => ShadBlueColorScheme.dark(),
      };
    }
    return ShadThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
    );
  }

  ThemeAccentState copyWith({AppThemeAccent? accent, Color? customColor}) {
    return ThemeAccentState(
      accent: accent ?? this.accent,
      customColor: customColor ?? this.customColor,
    );
  }
}

final themeAccentPod = NotifierProvider<ThemeAccentNotifier, ThemeAccentState>(
    ThemeAccentNotifier.new);

class ThemeAccentNotifier extends Notifier<ThemeAccentState> {
  static const _key = 'theme_accent';
  static const _customColorKey = 'custom_theme_color';

  @override
  ThemeAccentState build() {
    final storage = ref.read(appStorageProvider);
    final saved = storage.get(key: _key);
    final savedColor = storage.get(key: _customColorKey);

    AppThemeAccent accent = AppThemeAccent.midnight;
    if (saved != null) {
      accent = AppThemeAccent.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => AppThemeAccent.midnight,
      );
    }

    Color? customColor;
    if (savedColor != null) {
      customColor = Color(int.parse(savedColor, radix: 16));
    }

    return ThemeAccentState(accent: accent, customColor: customColor);
  }

  void updateTheme(AppThemeAccent accent) {
    state = state.copyWith(accent: accent);
    ref.read(appStorageProvider).put(key: _key, value: accent.name);
  }

  void updateCustomColor(Color color) {
    state = state.copyWith(accent: AppThemeAccent.custom, customColor: color);
    ref.read(appStorageProvider).put(key: _key, value: AppThemeAccent.custom.name);
    ref
        .read(appStorageProvider)
        .put(key: _customColorKey, value: color.toARGB32().toRadixString(16));
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
