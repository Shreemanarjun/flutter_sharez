import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(
    'Internet checker test',
    () {
      test(
        'if internt checker disabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWithValue(
                false,
              ),
            ],
          );

          addTearDown(container.dispose);

          final status =
              await container.read(internetCheckerNotifierPod.future);
          expect(status, InternetStatus.connected);
        },
      );
      test(
        'if internt checker enabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWithValue(
                true,
              ),
            ],
          );

          addTearDown(container.dispose);

          var status = await container.read(internetCheckerNotifierPod.future);
          expectLater(
            status,
            equals(InternetStatus.connected),
          );

          container
              .read(internetConnectionCheckerInstancePod)
              .onStatusChange
              .listen((event) {});
          final newStatus =
              await container.read(internetCheckerNotifierPod.future);

          expect(newStatus, InternetStatus.connected);
          expect(
              container
                  .read(internetConnectionCheckerInstancePod)
                  .checkInterval,
              equals(const Duration(seconds: 5)));
          container
              .read(internetCheckerNotifierPod.notifier)
              .change(status: InternetStatus.disconnected);
          expect(container.read(internetCheckerNotifierPod).requireValue,
              equals(InternetStatus.disconnected));
        },
      );
      test(
        'if internet checker enabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWithValue(
                true,
              ),
            ],
          );
          addTearDown(container.dispose);

          var status = await container.read(internetCheckerNotifierPod.future);
          expectLater(
            status,
            equals(InternetStatus.connected),
          );
          container
              .read(internetConnectionCheckerInstancePod)
              .onStatusChange
              .listen((event) {});

          expect(
              container
                  .read(internetConnectionCheckerInstancePod)
                  .checkInterval,
              equals(const Duration(seconds: 5)));
          container
              .read(internetCheckerNotifierPod.notifier)
              .change(status: InternetStatus.disconnected);
          expect(container.read(internetCheckerNotifierPod).requireValue,
              equals(InternetStatus.disconnected));
        },
      );
    },
  );
}
