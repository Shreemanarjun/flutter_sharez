import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/features/send/controller/notifier/send_state_notifier.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MockAppStorage extends Mock implements AppStorage {
  @override
  bool? getBool({required String key}) => false;
  @override
  String? get({required String key}) => '';
}

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
       final router = AppRouter();
       final t = AppLocale.en.buildSync();

       await tester.pumpWidget(
        ProviderScope(
          overrides: [
             autorouterProvider.overrideWithValue(router),
             translationsPod.overrideWith((ref) => t),
             sendStateNotifierPod.overrideWith(() => SimpleSendStateNotifier()),
             checkUpdateAvailablePod.overrideWithValue(const AsyncData(null)),
             appStorageProvider.overrideWithValue(MockAppStorage()),
          ],
          child: ShadApp.router(
            routerConfig: router.config(),
            builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
                ],
            ),
          ),
        ),
      );

      // Settle the initial build
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Search for any DropTarget in the resulting widget tree
      final dropTargetFinder = find.byType(DropTarget);
      expect(dropTargetFinder, findsOneWidget, reason: 'DropTarget should be present on HomePage');

      final dropTarget = tester.widget<DropTarget>(dropTargetFinder.first);

      // Update drag position
      dropTarget.onDragEntered?.call(
        DropEventDetails(
          localPosition: const Offset(100, 100),
          globalPosition: const Offset(100, 100),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify overlay feedback is visible
      expect(find.text("Drop to Share"), findsOneWidget, reason: 'Drag overlay should appear');

      // Trigger onDragExited
      dropTarget.onDragExited?.call(
        DropEventDetails(
          localPosition: Offset.zero,
          globalPosition: Offset.zero,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify overlay is GONE
      expect(find.text("Drop to Share"), findsNothing, reason: 'Drag overlay should disappear');

      // Clear any remaining timers
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
