import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/shared/widget/shortcuts_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRouter extends Mock implements AppRouter {}

void main() {
  group('ShortcutsWrapper Widget Tests', () {
    late MockAppRouter mockAppRouter;

    setUpAll(() {
       registerFallbackValue(const HomeRoute());
       registerFallbackValue(const SettingsRoute());
    });

    setUp(() {
      mockAppRouter = MockAppRouter();
      // Required because we call navigate
      when(() => mockAppRouter.navigate(any())).thenAnswer((_) async {});
    });

    testWidgets('Ctrl + S navigates to HomeRoute', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
             autorouterProvider.overrideWithValue(mockAppRouter),
          ],
          child: MaterialApp(
            home: ShortcutsWrapper(
              child: Focus(
                autofocus: true,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      // Trigger Ctrl + S
      await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyS);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
      await tester.pump();

      verify(() => mockAppRouter.navigate(const HomeRoute())).called(1);
    });

    testWidgets('Ctrl + , navigates to SettingsRoute', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
             autorouterProvider.overrideWithValue(mockAppRouter),
          ],
          child: MaterialApp(
            home: ShortcutsWrapper(
              child: Focus(
                autofocus: true,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      // Trigger Ctrl + ,
      await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
      await tester.sendKeyEvent(LogicalKeyboardKey.comma);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
      await tester.pump();

      verify(() => mockAppRouter.navigate(const SettingsRoute())).called(1);
    });
  });
}
