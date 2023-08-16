import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';

void main() {
  group(
    'Internet checker test',
    () {
      test(
        'if internt checker disabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [
              enableInternetCheckerPod.overrideWithValue(false),
            ],
          );
          addTearDown(container.dispose);

          final status = await container.read(internetCheckerPod.future);
          expect(status, InternetConnectionStatus.connected);
        },
      );
      test(
        'if internt checker enabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [],
          );
          addTearDown(container.dispose);

          final status = await container.read(internetCheckerPod.future);
          expect(
            container.read(internetConnectionCheckerPod).hasListeners,
            equals(false),
          );
          container
              .read(internetConnectionCheckerPod)
              .onStatusChange
              .listen((event) {});
          expect(
            container.read(internetConnectionCheckerPod).hasListeners,
            equals(true),
          );
          expect(status, InternetConnectionStatus.connected);
          expect(container.read(internetConnectionCheckerPod).checkInterval,
              equals(const Duration(seconds: 5)));
          container
              .read(internetCheckerPod.notifier)
              .change(status: InternetConnectionStatus.disconnected);
          expect(container.read(internetCheckerPod).requireValue,
              equals(InternetConnectionStatus.disconnected));
        },
      );
    },
  );
}
