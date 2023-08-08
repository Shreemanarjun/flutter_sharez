import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';
import 'package:flutter_sharez/shared/widget/no_internet_widget.dart';

import '../../helpers/pump_app.dart';

class TestInternetStatusNotifier
    extends AutoDisposeStreamNotifier<InternetConnectionStatus>
    implements InternetStatusNotifier {
  final Stream<InternetConnectionStatus> Function() streamBuild;

  TestInternetStatusNotifier({required this.streamBuild});

  @override
  Stream<InternetConnectionStatus> build() {
    return streamBuild.call();
  }

  @override
  void change({required InternetConnectionStatus status}) {
    state = AsyncValue.data(status);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('No Internet Widget Test', () {
    testWidgets('renders the child when internet available ', (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            internetCheckerPod.overrideWith(
              () => TestInternetStatusNotifier(
                streamBuild: () {
                  return Stream.value(InternetConnectionStatus.connected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').noInternetWidget(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
    });
    testWidgets(
        'renders the no internet widget child when internet is not available ',
        (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            internetCheckerPod.overrideWith(
              () => TestInternetStatusNotifier(
                streamBuild: () {
                  return Stream.value(InternetConnectionStatus.disconnected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').noInternetWidget(
                noInternetWidget: const Text('I am no internet child')),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsNothing);
      expect(find.text('I am no internet child'), findsOneWidget);
    });
    testWidgets(
        'renders the child when internet available without maintaining state ',
        (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            internetCheckerPod.overrideWith(
              () => TestInternetStatusNotifier(
                streamBuild: () {
                  return Stream.value(InternetConnectionStatus.connected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').noInternetWidget(
              maintainState: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
    });
    testWidgets(
        'renders the no internet widget child when internet is not available with no maintained state ',
        (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            internetCheckerPod.overrideWith(
              () => TestInternetStatusNotifier(
                streamBuild: () {
                  return Stream.value(InternetConnectionStatus.disconnected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').noInternetWidget(
              noInternetWidget: const Text('I am no internet child'),
              maintainState: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsNothing);
      expect(find.text('I am no internet child'), findsOneWidget);
    });
    testWidgets('renders error message  when any exception happened ',
        (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
            internetCheckerPod.overrideWith(
              () => TestInternetStatusNotifier(
                streamBuild: () {
                  throw "Error in connection";
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').noInternetWidget(
              noInternetWidget: const Text('I am no internet child'),
              maintainState: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text("Error in connection"), findsOneWidget);
    });
    testWidgets('renders child on web platform ', (tester) async {
      await tester.pumpApp(
        ProviderScope(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(false),
          ],
          child: Scaffold(
            body: const Text(
              'I am the child',
              key: ValueKey('child'),
            ).noInternetWidget(
              noInternetWidget: const Text('I am no internet child'),
              maintainState: false,
              enableCheck: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
      expect(find.byKey(const ValueKey('child')), findsOneWidget);
      expect(find.text('I am no internet child'), findsNothing);
    });
    testWidgets('renders snackbar on internet reconnected', (tester) async {
      final ProviderContainer container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          internetCheckerPod.overrideWith(
            () => TestInternetStatusNotifier(
              streamBuild: () async* {
                yield InternetConnectionStatus.disconnected;
              },
            ),
          )
        ],
      );
      await tester.pumpApp(
        ProviderScope(
          parent: container,
          child: Scaffold(
            body: const Text(
              'I am the child',
            ).noInternetWidget(
              noInternetWidget: const Text('I am no internet child'),
              maintainState: false,
              enableCheck: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('I am the child'), findsNothing);
      expect(find.text('I am no internet child'), findsOneWidget);
      expect(find.text('No Internet Available'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      container
          .read(internetCheckerPod.notifier)
          .change(status: InternetConnectionStatus.connected);

      await tester.pumpAndSettle();
      await tester.runAsync(
        () async {
          expect(find.text('I am the child'), findsOneWidget);
          expect(find.text('I am no internet child'), findsNothing);
          //await tester.pumpAndSettle(const Duration(seconds: 3));
          expect(
              find.text('Got Internet ...... Refreshed', skipOffstage: false),
              findsOneWidget);
          expect(find.text('OK'), findsOneWidget);
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle(const Duration(seconds: 5));
          expect(
              find.text('Got Internet ...... Refreshed', skipOffstage: false),
              findsNothing);
        },
      );
    });
    testWidgets('check no internet pod refreshed on ok clicked on snackbar',
        (tester) async {
      final ProviderContainer container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          internetCheckerPod.overrideWith(
            () => TestInternetStatusNotifier(
              streamBuild: () async* {
                yield InternetConnectionStatus.disconnected;
              },
            ),
          )
        ],
      );
      await tester.pumpApp(
        ProviderScope(
          parent: container,
          child: Scaffold(
            body: const Text(
              'I am the child',
            ).noInternetWidget(
              noInternetWidget: const Text('I am no internet child'),
              maintainState: false,
              enableCheck: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('I am the child'), findsNothing);
      expect(find.text('I am no internet child'), findsOneWidget);
      expect(find.text('No Internet Available'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 10));
      await tester.tap(find.text('OK'));
      expect(container.read(internetCheckerPod).isRefreshing, true);
      expect(container.read(internetCheckerPod).isReloading, false);
      expect(container.read(internetCheckerPod).isLoading, true);
      await tester.pumpAndSettle(const Duration(seconds: 10));
      container
          .read(internetCheckerPod.notifier)
          .change(status: InternetConnectionStatus.connected);

      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('I am the child'), findsOneWidget);
      expect(find.text('I am no internet child'), findsNothing);
      expect(find.text('No Internet Available'), findsNothing);
    });
  });
}
