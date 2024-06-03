// ignore_for_file: deprecated_member_use, avoid_public_notifier_properties

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';
import 'package:flutter_sharez/shared/widget/no_internet_widget.dart';
import '../../helpers/pump_app.dart';

class TestInternetStatusNotifier
    extends AutoDisposeStreamNotifier<InternetStatus>
    implements InternetStatusNotifier {
  final Stream<InternetStatus> Function() streamBuild;

  TestInternetStatusNotifier({required this.streamBuild});

  @override
  Stream<InternetStatus> build() {
    return streamBuild.call();
  }

  @override
  void change({required InternetStatus status}) {
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
                  return Stream.value(InternetStatus.connected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').monitorConnection(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
      expect(find.text('No Internet Available'), findsNothing);
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
                  return Stream.value(InternetStatus.disconnected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').monitorConnection(
                noInternetWidget: const Text('I am no internet child')),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
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
                  return Stream.value(InternetStatus.connected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').monitorConnection(),
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
                  return Stream.value(InternetStatus.disconnected);
                },
              ),
            )
          ],
          child: Scaffold(
            body: const Text('I am the child').monitorConnection(
              noInternetWidget: const Text('I am no internet child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
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
            body: const Text('I am the child').monitorConnection(
              noInternetWidget: const Text('I am no internet child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text("Unable to check internet due to Error in connection"),
          findsOneWidget);
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
            ).monitorConnection(
              noInternetWidget: const Text('I am no internet child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('I am the child'), findsOneWidget);
      expect(find.byKey(const ValueKey('child')), findsOneWidget);
      expect(find.text('I am no internet child'), findsNothing);
    });
    testWidgets('renders child only on internet reconnected', (tester) async {
      final ProviderContainer container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          internetCheckerPod.overrideWith(
            () => TestInternetStatusNotifier(
              streamBuild: () async* {
                yield InternetStatus.disconnected;
              },
            ),
          )
        ],
      );
      await tester.pumpApp(
        UncontrolledProviderScope(
          container: container,
          child: Scaffold(
            body: const Text(
              'I am the child',
            ).monitorConnection(
              noInternetWidget: const Text('I am no internet child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('I am the child'), findsOneWidget);
      expect(find.text('I am no internet child'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      container
          .read(internetCheckerPod.notifier)
          .change(status: InternetStatus.connected);

      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      await tester.runAsync(
        () async {
          expect(find.text('I am the child'), findsOneWidget);
          expect(find.text('I am no internet child'), findsNothing);
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
                yield InternetStatus.disconnected;
              },
            ),
          )
        ],
      );

      await tester.pumpApp(
        UncontrolledProviderScope(
          container: container,
          child: Material(
            child: const Scaffold(
              body: Text(
                'I am the child',
              ),
            ).monitorConnection(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final childWidget = find.text('I am the child', skipOffstage: false);
      expect(childWidget, findsOneWidget);
      final okButton =
          find.byKey(const ValueKey('OK_BUTTON'), skipOffstage: false);
      await tester.ensureVisible(okButton);
      await tester.pumpAndSettle();

      await tester.tap(okButton);
      expect(container.read(internetCheckerPod).isRefreshing, isTrue);
      await tester.pumpAndSettle(
          const Duration(milliseconds: 500)); // Add a slight delay

      container
          .read(internetCheckerPod.notifier)
          .change(status: InternetStatus.connected);
      await tester.runAsync(() async {
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        expect(childWidget, findsOneWidget);
        expect(find.text('No Internet Available'), findsNothing);

        ///  await takeScreenshot();
      });
    });
    testWidgets(
        'check no internet pod refreshed on ok clicked on snackbar when error occured',
        (tester) async {
      final ProviderContainer container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWithValue(false),
          internetCheckerPod.overrideWith(
            () => TestInternetStatusNotifier(
              streamBuild: () {
                return Stream.error("Error");
              },
            ),
          )
        ],
      );

      await tester.pumpApp(
        UncontrolledProviderScope(
          container: container,
          child: Material(
            child: const Scaffold(
              body: Text(
                'I am the child',
              ),
            ).monitorConnection(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final retryBtn = find.textContaining("Retry");
      await tester.ensureVisible(retryBtn);
      await tester.pumpAndSettle();
      await tester.tap(retryBtn);
      expect(container.read(internetCheckerPod).isRefreshing, isTrue);
    });
  });
}
