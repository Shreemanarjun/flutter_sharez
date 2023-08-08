import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:riverpod_test/riverpod_test.dart';

Future<void> main() async {
  group(
    'App Storage Test',
    () {
      AppStorage appStorage = AppStorage(null);
      setUp(() async {
        await appStorage.init(isTest: true);
      });
      testProvider(
        'throw exception without intialization',
        provider: appStorageProvider,
        errors: () => [
          isA<UnimplementedError>().having(
            (s) => s.message,
            'error message',
            equals('appBoxProvider is not overriden'),
          )
        ],
      );
      testProvider(
        'intiailize and check box have no data',
        provider: appStorageProvider,
        overrides: [appStorageProvider.overrideWithValue(appStorage)],
        verify: () => [
          expectLater(
            appStorage.appBox?.values.isEmpty,
            true,
          ),
          expectLater(
            appStorage.appBox?.toMap(),
            equals({}),
          ),
        ],
      );
      testProvider(
        'store a value and check not null in the box',
        provider: appStorageProvider,
        overrides: [
          appStorageProvider.overrideWithValue(appStorage),
        ],
        setUp: () async {
          await appStorage.put(key: 'hello', value: 'world');
        },
        tearDown: () async {
          await appStorage.clearAllData();
        },
        verify: () => [
          expectLater(
            appStorage.appBox?.values.isEmpty,
            false,
          ),
          expectLater(
            appStorage.appBox?.toMap(),
            equals({'hello': 'world'}),
          ),
          expect(
            appStorage.get(key: 'hello'),
            isNotNull,
          ),
          expect(
            appStorage.get(key: 'hello'),
            equals('world'),
          ),
        ],
      );
      testProvider(
        'check cleardata and box should be null',
        provider: appStorageProvider,
        overrides: [
          appStorageProvider.overrideWithValue(appStorage),
        ],
        setUp: () async {
          await appStorage.clearAllData();
        },
        tearDown: () async {
          await appStorage.clearAllData();
        },
        verify: () => [
          expectLater(
            appStorage.appBox?.values.isEmpty,
            true,
          ),
          expectLater(
            appStorage.appBox?.toMap(),
            equals({}),
          ),
          expect(
            appStorage.get(key: 'hello'),
            isNull,
          ),
        ],
      );
    },
  );
}
