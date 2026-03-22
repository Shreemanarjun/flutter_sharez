import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/service/receive/push_receiver_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppStorage extends Mock implements AppStorage {}

void main() {
  group('PushReceiverService Tests', () {
    late ProviderContainer container;
    late MockAppStorage mockAppStorage;
    late PushReceiverService pushReceiverService;
    late Ref ref;

    setUp(() {
      mockAppStorage = MockAppStorage();
      
      container = ProviderContainer(
        overrides: [
          appStorageProvider.overrideWithValue(mockAppStorage),
        ],
      );
      
      final dummyProvider = Provider((r) {
        ref = r;
        return null;
      });
      container.read(dummyProvider);

      when(() => mockAppStorage.get(key: any(named: 'key'))).thenReturn('test-uuid');
      
      pushReceiverService = PushReceiverService(ref);
    });

    test('Initializes but does not start automatically in unit test (requires manual start)', () {
      expect(pushReceiverService.port, isNull);
    });

    test('stop handles uninitialized server gracefully', () {
      expectLater(() => pushReceiverService.stop(), returnsNormally);
    });
  });
}
