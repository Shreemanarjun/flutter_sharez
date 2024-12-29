import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/features/counter/counter.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CounterPage', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() {
      appBox.clear();
    });
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            appBoxProvider.overrideWithValue(appBox),
          ],
          child: const CounterPage(),
        ),
      );
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() {
      appBox.clear();
    });
    testWidgets('renders current count', (tester) async {
      const state = 42;

      final container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          appBoxProvider.overrideWithValue(appBox),
          intialCounterValuePod.overrideWithValue(state),
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
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      const state = 42;

      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            appBoxProvider.overrideWithValue(appBox),
            intialCounterValuePod.overrideWithValue(state),
          ],
          child: const CounterView(),
        ),
      );
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('42'), findsNothing);
      expect(find.text('43'), findsOneWidget);
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      const state = 42;
      final container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          appBoxProvider.overrideWithValue(appBox),
          intialCounterValuePod.overrideWithValue(state),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(
        UncontrolledProviderScope(
          container: container,
          child: const CounterView(),
        ),
      );
      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('42'), findsNothing);
      expect(find.text('41'), findsOneWidget);
    });
  });
}
