import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/theme/app_theme_pod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/features/settings/controller/settings_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spot/spot.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockAppStorage extends Mock implements AppStorage {
  @override
  bool? getBool({required String key}) => false;
  @override
  String? get({required String key}) => '';
}

class MockDeviceNameNotifier extends DeviceNameNotifier {
  @override
  String build() => 'MacBook Pro';
}

class MockAutoStartNotifier extends AutoStartNotifier {
  @override
  bool build() => true;
}

class MockDownloadPathNotifier extends DownloadPathNotifier {
  @override
  String? build() => '/Users/mock/Downloads/Sharez';
}

class MockThemeModeNotifier extends ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.light;
}

class MockThemeAccentNotifier extends ThemeAccentNotifier {
  @override
  ThemeAccentState build() => ThemeAccentState(accent: AppThemeAccent.midnight);
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  goldenTest(
    name: 'SettingsPage Visuals',
    supportedDevices: [
      const Device( // Phone
        name: 'phone',
        width: 393,
        height: 852,
        devicePixelRatio: 3,
        insets: EdgeInsets.zero,
      ),
      const Device( // Tablet
        name: 'tablet',
        width: 1024,
        height: 1366,
        devicePixelRatio: 2,
        insets: EdgeInsets.zero,
      ),
      const Device( // Desktop
        name: 'desktop',
        width: 1440,
        height: 900,
        insets: EdgeInsets.zero,
      ),
    ],
    builder: (_) {
      final t = AppLocale.en.buildSync();
      final router = AppRouter();

      return ProviderScope(
        overrides: [
          autorouterProvider.overrideWithValue(router),
          translationsPod.overrideWith((ref) => t),
          appStorageProvider.overrideWithValue(MockAppStorage()),
          deviceNameProvider.overrideWith(MockDeviceNameNotifier.new),
          autoStartServerProvider.overrideWith(MockAutoStartNotifier.new),
          downloadPathProvider.overrideWith(MockDownloadPathNotifier.new),
          themeModePod.overrideWith(MockThemeModeNotifier.new),
          themeAccentPod.overrideWith(MockThemeAccentNotifier.new),
        ],
        child: ShadApp.router(
          routerConfig: router.config(
            deepLinkBuilder: (_) => const DeepLink([SettingsRoute()]),
          ),
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
            ],
          ),
        ),
      );
    },
    action: (tester) async {
      tester.view.padding = FakeViewPadding.zero;
      tester.view.viewPadding = FakeViewPadding.zero;
      await tester.pump();
    },
  );
}
