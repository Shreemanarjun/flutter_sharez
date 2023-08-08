import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/init.dart';

Future<void> main() async {
  group(
    'check init is working ',
    () {
      testWidgets('It should be in the landscape view', (tester) async {
        final widget = OrientationBuilder(
          builder: (context, orientation) {
            return Text(orientation.name);
          },
        );

        final logs = [];

        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            SystemChannels.platform, (methodCall) async {
          if (methodCall.method == 'SystemChrome.setPreferredOrientations') {
            logs.add((methodCall.arguments as List)[0]);
          }
          return null;
        });

        expect(logs.length, 0);

        await tester.pumpWidget(
          MaterialApp(
            home: widget,
          ),
        );
        await init();

        expect(logs.length, 1,
            reason: 'It should have pushed a log after the initState');
        expect(logs.first, 'DeviceOrientation.portraitUp',
            reason: 'It should be in the landscape view after the initState');
      });
    },
  );
}
