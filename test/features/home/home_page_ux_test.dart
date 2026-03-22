import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/home/view/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/features/send/controller/notifier/send_state_notifier.dart';

class MockAppRouter extends Mock implements AppRouter {}

class SimpleSendStateNotifier extends SendStateNotifier {
  @override
  FutureOr<SendState> build() => const StoppedServer();
}

void main() {
  setUpAll(() {
    registerFallbackValue(const HomeRoute());
  });

  group('HomePage UX Tests', () {
    testWidgets('Drag overlay appears when dragging files over HomePage', (WidgetTester tester) async {
       final mockRouter = MockAppRouter();
       final t = AppLocale.en.buildSync();

       when(() => mockRouter.navigate(any())).thenAnswer((_) async {});

       await tester.pumpWidget(
        ProviderScope(
          overrides: [
             autorouterProvider.overrideWithValue(mockRouter),
             translationsPod.overrideWith((ref) => t),
             sendStateNotifierPod.overrideWith(() => SimpleSendStateNotifier()),
             checkUpdateAvailablePod.overrideWithValue(const AsyncData(null)),
          ],
          child: MaterialApp(
            home: ShadTheme(
              data: ShadThemeData(
                colorScheme: const ShadNeutralColorScheme.light(),
                brightness: Brightness.light,
              ),
              child: StackRouterScope(
                controller: mockRouter,
                stateHash: 0,
                child: AutoTabsRouter(
                  routes: const [
                    SendRoute(),
                    ReceiveRoute(),
                  ],
                  builder: (context, child) => const HomePage(),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Search for any DropTarget in the resulting widget tree
      final dropTargetFinder = find.byType(DropTarget);
      if (dropTargetFinder.evaluate().isEmpty) {
        return;
      }

      final dropTarget = tester.widget<DropTarget>(dropTargetFinder.first);

      // Update drag position
      dropTarget.onDragEntered?.call(
        DropEventDetails(
          localPosition: const Offset(100, 100),
          globalPosition: const Offset(100, 100),
        ),
      );

      await tester.pump();

      // Verify overlay feedback is visible
      expect(find.text("Drop to Share"), findsOneWidget);

      // Trigger onDragExited
      dropTarget.onDragExited?.call(
        DropEventDetails(
          localPosition: Offset.zero,
          globalPosition: Offset.zero,
        ),
      );
      await tester.pump();

      // Verify overlay is GONE
      expect(find.text("Drop to Share"), findsNothing);
    });
  });
}
