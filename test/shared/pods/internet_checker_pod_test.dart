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
              enableInternetCheckerPod.overrideWithValue(false),
            ],
          );
          addTearDown(container.dispose);

          final status = await container.read(internetCheckerPod.future);
          expect(status, InternetStatus.connected);
        },
      );
      test(
        'if internt checker enabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [enableInternetCheckerPod.overrideWithValue(false)],
          );
          addTearDown(container.dispose);

          final status = await container.read(internetCheckerPod.future);
          expectLater(
            await container
                .read(internetConnectionCheckerPod)
                .hasInternetAccess,
            equals(true),
          );
          container
              .read(internetConnectionCheckerPod)
              .onStatusChange
              .listen((event) {});

          expect(status, InternetStatus.connected);
          expect(container.read(internetConnectionCheckerPod).checkInterval,
              equals(const Duration(seconds: 5)));
          container
              .read(internetCheckerPod.notifier)
              .change(status: InternetStatus.disconnected);
          expect(container.read(internetCheckerPod).requireValue,
              equals(InternetStatus.disconnected));
        },
      );
      test(
        'if internet checker enabled then by deafult internetstatus should be connected',
        () async {
          final container = ProviderContainer(
            overrides: [],
          );
          addTearDown(container.dispose);

          final status = await container.read(internetCheckerPod.future);
          expectLater(
            await container
                .read(internetConnectionCheckerPod)
                .hasInternetAccess,
            equals(true),
          );
          container
              .read(internetConnectionCheckerPod)
              .onStatusChange
              .listen((event) {});

          expect(status, InternetStatus.connected);
          expect(container.read(internetConnectionCheckerPod).checkInterval,
              equals(const Duration(seconds: 5)));
          container
              .read(internetCheckerPod.notifier)
              .change(status: InternetStatus.disconnected);
          expect(container.read(internetCheckerPod).requireValue,
              equals(InternetStatus.disconnected));
        },
      );
    },
  );
}
