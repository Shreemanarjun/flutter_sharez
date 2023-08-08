import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/features/counter/counter.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';

import '../../helpers/pump_app.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Box appBox;
  setUp(() async {
    appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
  });
  tearDown(() {
    appBox.clear();
  });
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            appBoxProvider.overrideWithValue(appBox),
          ],
          child: const CounterPage(),
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
