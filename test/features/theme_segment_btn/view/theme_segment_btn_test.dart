// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/core/theme/app_theme.dart';
import 'package:flutter_sharez/core/theme/theme_controller.dart';
import 'package:flutter_sharez/features/counter/counter.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/controller/selection_theme_pod.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Theme Segment Button Test',
    () {
      late Box appBox;
      setUp(() async {
        appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
      });
      tearDown(() {
        appBox.clear();
      });
      testWidgets(
        'renderes ThemeSegmentBtn',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          await tester.pumpApp(
            UncontrolledProviderScope(
              container: container,
              child: const CounterView(),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        },
      );
      testWidgets(
        'renderes ThemeSefementBtn with ThemeMode.System at Intial',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          await tester.pumpApp(
            UncontrolledProviderScope(
              container: container,
              child: const CounterView(),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
          expect(find.byIcon(Icons.check), findsOneWidget);
        },
      );

      testWidgets(
        'renderes ThemeSefementBtn with ThemeMode.light on select light mode',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          final currentTheme = container.read(themecontrollerProvider);
          await tester.pumpApp(
            ProviderScope(
              parent: container,
              child: MaterialApp(
                theme: Themes.theme,
                darkTheme: Themes.darkTheme,
                themeMode: currentTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const CounterView(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.light_mode), findsOneWidget);
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.light_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod),
                  equals({
                    ThemeMode.light,
                  }));
            },
          );
        },
      );
      testWidgets(
        'renderes ThemeSefementBtn with ThemeMode.dark on select dark mode',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          final currentTheme = container.read(themecontrollerProvider);
          await tester.pumpApp(
            ProviderScope(
              parent: container,
              child: MaterialApp(
                theme: Themes.theme,
                darkTheme: Themes.darkTheme,
                themeMode: currentTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const CounterView(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.dark_mode), findsOneWidget);
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.dark_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod), equals({ThemeMode.dark}));
            },
          );
        },
      );
      testWidgets(
        'renderes ThemeSegementBtn with ThemeMode.system after change from dark mode to system mode',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          final currentTheme = container.read(themecontrollerProvider);
          await tester.pumpApp(
            ProviderScope(
              parent: container,
              child: MaterialApp(
                theme: Themes.theme,
                darkTheme: Themes.darkTheme,
                themeMode: currentTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const CounterView(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.dark_mode), findsOneWidget);
          expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.dark_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod), equals({ThemeMode.dark}));
            },
          );
          await tester.pump();
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.brightness_auto));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod),
                  equals({
                    ThemeMode.system,
                  }));
            },
          );
        },
      );
      testWidgets(
        'renderes ThemeSegementBtn with ThemeMode.system after change from light mode to system mode',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          final currentTheme = container.read(themecontrollerProvider);
          await tester.pumpApp(
            ProviderScope(
              parent: container,
              child: MaterialApp(
                theme: Themes.theme,
                darkTheme: Themes.darkTheme,
                themeMode: currentTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const CounterView(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.light_mode), findsOneWidget);
          expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.light_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod), equals({ThemeMode.light}));
            },
          );
          await tester.pump();
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.brightness_auto));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod),
                  equals({
                    ThemeMode.system,
                  }));
            },
          );
        },
      );
      testWidgets(
        'renderes ThemeSegementBtn with ThemeMode.dark after change from light mode to dark mode',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWith(
                (ref) => false,
              ),
              appBoxProvider.overrideWithValue(appBox),
            ],
          );
          addTearDown(container.dispose);
          final currentTheme = container.read(themecontrollerProvider);
          await tester.pumpApp(
            ProviderScope(
              parent: container,
              child: MaterialApp(
                theme: Themes.theme,
                darkTheme: Themes.darkTheme,
                themeMode: currentTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const CounterView(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
          expect(find.byIcon(Icons.light_mode), findsOneWidget);
          expect(find.byIcon(Icons.dark_mode), findsOneWidget);
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.light_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod), equals({ThemeMode.light}));
            },
          );
          await tester.pump();
          await tester.runAsync(
            () async {
              await tester.tap(find.byIcon(Icons.dark_mode));
              expect(container.read(themeSelectionPod).length, 1);
              expect(
                  container.read(themeSelectionPod),
                  equals({
                    ThemeMode.dark,
                  }));
            },
          );
        },
      );
    },
  );
}
