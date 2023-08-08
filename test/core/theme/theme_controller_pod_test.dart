import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/core/theme/theme_controller.dart';
import 'package:riverpod_test/riverpod_test.dart';

void main() {
  group('ThemeModeController Test', () {
    AppStorage appStorage = AppStorage(null);
    setUp(() async {
      await appStorage.init(isTest: true);
    });
    tearDown(() async {
      await appStorage.clearAllData();
    });
    testNotifier(
      'expect ThemeMode.system on first time',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      emitBuildStates: true,
      expect: () => [
        ThemeMode.system,
      ],
    );
    testNotifier(
      'expect ThemeMode.light after change the theme to ThemeMode.light',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      emitBuildStates: true,
      act: (notifier) async => await notifier.changeTheme(ThemeMode.light),
      expect: () => [
        ThemeMode.system,
        ThemeMode.light,
      ],
    );
    testNotifier(
      'expect ThemeMode.dark after change the theme to ThemeMode.light and then ThemeMode.dark',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      emitBuildStates: true,
      act: (notifier) async {
        await notifier.changeTheme(ThemeMode.light);
        await notifier.changeTheme(ThemeMode.dark);
      },
      expect: () => [
        ThemeMode.system,
        ThemeMode.light,
        ThemeMode.dark,
      ],
    );
    testNotifier(
      'check persistence ThemeMode.light',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      setUp: () async {
        await appStorage.put(key: 'theme', value: ThemeMode.light.name);
      },
      emitBuildStates: true,
      expect: () => [
        ThemeMode.light,
      ],
    );
    testNotifier(
      'check persistence ThemeMode.dark',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      setUp: () async {
        await appStorage.put(key: 'theme', value: ThemeMode.dark.name);
      },
      emitBuildStates: true,
      expect: () => [
        ThemeMode.dark,
      ],
    );
    testNotifier(
      'check persistence ThemeMode.system',
      provider: themecontrollerProvider,
      overrides: [appStorageProvider.overrideWithValue(appStorage)],
      setUp: () async {
        await appStorage.put(key: 'theme', value: ThemeMode.system.name);
      },
      emitBuildStates: true,
      expect: () => [
        ThemeMode.system,
      ],
    );
  });
}
