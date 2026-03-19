import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:flutter_sharez/shared/pods/locale_pod.dart';

void main() {
  group(
    'Locale Pod Test',
    () {
      final appStorage = AppStorage(null);
      setUp(() async {
        await appStorage.init(isTest: true);
      });
      tearDown(() async {
        await appStorage.clearAllData();
      });

      test("check default locale should be English", () async {
        final container = ProviderContainer(
          overrides: [
            appStorageProvider.overrideWithValue(appStorage),
          ],
        );
        addTearDown(container.dispose);

        final state = container.read(localePod);
        expect(state, const Locale.fromSubtags(languageCode: 'en'));
      });

      test("check default locale should be English and after change it should be Spanish", () async {
        final container = ProviderContainer(
          overrides: [
            appStorageProvider.overrideWithValue(appStorage),
          ],
        );
        addTearDown(container.dispose);

        expect(container.read(localePod), const Locale.fromSubtags(languageCode: 'en'));

        await container.read(localePod.notifier).changeLocale(
              locale: const Locale.fromSubtags(languageCode: 'es'),
            );

        expect(container.read(localePod), const Locale.fromSubtags(languageCode: 'es'));
      });

      test("check default locale should be English and after change it to Arabic, it should throw as it not supported", () async {
        final container = ProviderContainer(
          overrides: [
            appStorageProvider.overrideWithValue(appStorage),
          ],
        );
        addTearDown(container.dispose);

        expect(container.read(localePod), const Locale.fromSubtags(languageCode: 'en'));

        expect(
          () => container.read(localePod.notifier).changeLocale(
                locale: const Locale.fromSubtags(languageCode: 'ar'),
              ),
          throwsA(
            isA<BaseException>().having(
              (s) => s.message,
              'error message',
              contains('Language not supported'),
            ),
          ),
        );
      });
    },
  );
}
