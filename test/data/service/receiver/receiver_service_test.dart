import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReceiverService Logic Tests', () {
    late ReceiverService receiverService;
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      // Using a simple provider to obtain a Ref instance safely within the test environment.
      // This avoids issues with mocking sealed classes.
      final ref = container.read(Provider((ref) => ref));
      receiverService = ReceiverService(ref);
    });

    tearDown(() {
      container.dispose();
    });

    test('connectToDevice handles failure result correctly (simulated by non-existent IP)', () async {
      final cancelToken = CancelToken();
      final result = await receiverService.connectToDevice(
        ip: '127.0.0.1',
        port: '1', // Invalid port for anything real
        currentIP: '192.168.1.1',
        localPort: 1234,
        deviceUUID: 'uuid',
        cancelToken: cancelToken,
      );

      // Should return error result from failure
      expect(result.isError(), true);
    });

    test('getFilePaths handles error correctly (simulated by invalid IP)', () async {
      final cancelToken = CancelToken();
      final result = await receiverService.getFilePaths(
        ip: 'invalid-host',
        port: '8080',
        cancelToken: cancelToken,
      );

      expect(result.isError(), true);
    });
  });
}
