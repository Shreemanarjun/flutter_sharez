import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/pods/locale_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';
import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class AppStorageMock extends Mock implements AppStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Locale Popup Test', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() {
      appBox.clear();
    });
    testWidgets(
        'renders Applocalepopup within default English should be selected ',
        (tester) async {
      final appStorage = AppStorageMock();
      when(() => appStorage.get(key: any(named: "key"))).thenReturn('en');

      final container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWith(
            (ref) => false,
          ),
          appBoxProvider.overrideWithValue(appBox),
          appStorageProvider.overrideWithValue(appStorage),
        ],
      );
      await tester.pumpApp(
        UncontrolledProviderScope(
          container: container,
          child: const Scaffold(
            body: AppLocalePopUp(),
          ),
        ),
      );
      expect(find.byType(AppLocalePopUp), findsOneWidget);
      expectLater(
        container.read(localePod),
        AppLocalizations.supportedLocales.first,
      );
      await tester.runAsync(() async {
        await tester.tap(find.text("English"));
        await tester.pumpAndSettle();
      });

      expect(
          find.widgetWithText(
            SelectedLocaleItem,
            'English',
            skipOffstage: false,
          ),
          findsOneWidget);
    });
    testWidgets('renders Applocalepopup within Spanish if selected Spanish ',
        (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWith(
              (ref) => false,
            ),
            appBoxProvider.overrideWithValue(appBox),
          ],
          child: const Scaffold(
            body: AppLocalePopUp(),
          ),
        ),
      );
      expect(find.byType(AppLocalePopUp), findsOneWidget);
      await tester.runAsync(() async {
        await tester.tap(find.text("English"));
        await tester.pumpAndSettle();
      });
      expect(
          find.widgetWithText(
            SelectedLocaleItem,
            'English',
            skipOffstage: false,
          ),
          findsOneWidget);
      await tester.runAsync(() async {
        await tester.tap(find.text('Spanish'));
      });
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await tester.tap(find.text("Spanish"));
        await tester.pumpAndSettle();
      });
      expect(
          find.widgetWithText(
            SelectedLocaleItem,
            'Spanish',
            skipOffstage: false,
          ),
          findsOneWidget);
      expect(
          find.widgetWithText(
            UnselectedLocaleItem,
            'English',
            skipOffstage: false,
          ),
          findsOneWidget);
    });
  });
}
