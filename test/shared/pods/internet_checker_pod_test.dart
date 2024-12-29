import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

class TestInternetConnection extends Mock implements InternetConnection {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Internet checker test', () {
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
        expect(
            container.read(internetConnectionCheckerInstancePod).checkInterval,
            equals(const Duration(seconds: 5)));
        addTearDown(container.dispose);

        final status = await container.read(internetCheckerNotifierPod.future);
        expect(status, InternetStatus.connected);
      },
    );
    test(
      "if internet checker is enabled then by default internetstatus should be disconnected",
      () async {
        final internetConnection = TestInternetConnection();
        when(() => internetConnection.onStatusChange).thenAnswer(
          (invocation) => Stream.value(
            InternetStatus.connected,
          ),
        );
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(
              true,
            ),
            internetConnectionCheckerInstancePod
                .overrideWithValue(internetConnection),
          ],
        );

        addTearDown(container.dispose);

        final status = await container.read(internetCheckerNotifierPod.future);
        expect(status, InternetStatus.connected);
      },
    );

    test(
      'if internet checker enabled then by deafult internetstatus should be connected and on change status it should be disconnected',
      () async {
        final internetConnection = TestInternetConnection();
        when(() => internetConnection.onStatusChange).thenAnswer(
          (invocation) => Stream.value(
            InternetStatus.connected,
          ),
        );
        when(() => internetConnection.checkInterval).thenAnswer(
          (invocation) => Duration(seconds: 5),
        );
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWithValue(
              true,
            ),
            internetConnectionCheckerInstancePod
                .overrideWithValue(internetConnection),
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
            container.read(internetConnectionCheckerInstancePod).checkInterval,
            equals(const Duration(seconds: 5)));
        container
            .read(internetCheckerNotifierPod.notifier)
            .change(status: InternetStatus.disconnected);
        expect(container.read(internetCheckerNotifierPod).requireValue,
            equals(InternetStatus.disconnected));
      },
    );
  });
}
