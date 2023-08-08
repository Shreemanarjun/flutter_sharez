import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:flutter_sharez/shared/pods/locale_pod.dart';
import 'package:riverpod_test/riverpod_test.dart';

void main() {
  group(
    'Locale Pod Test',
    () {
      AppStorage appStorage = AppStorage(null);
      setUp(() async {
        await appStorage.init(isTest: true);
      });
      tearDown(() async {
        await appStorage.clearAllData();
      });

      testNotifier(
        "check default locale should be English",
        provider: localePod,
        overrides: [
          appStorageProvider.overrideWithValue(appStorage),
        ],
        emitBuildStates: true,
        expect: () => [
          const Locale.fromSubtags(languageCode: 'en'),
        ],
      );
      testNotifier(
        "check default locale should be English and after change it should be Arabic",
        provider: localePod,
        overrides: [
          appStorageProvider.overrideWithValue(appStorage),
        ],
        emitBuildStates: true,
        act: (notifier) async => await notifier.changeLocale(
            locale: const Locale.fromSubtags(languageCode: 'es')),
        expect: () => [
          const Locale.fromSubtags(languageCode: 'en'),
          const Locale.fromSubtags(languageCode: 'es'),
        ],
      );
      testNotifier(
        "check default locale should be English and after change it to Spanish,it should throw as it not supported",
        provider: localePod,
        overrides: [
          appStorageProvider.overrideWithValue(appStorage),
        ],
        emitBuildStates: true,
        act: (notifier) async => await notifier.changeLocale(
            locale: const Locale.fromSubtags(languageCode: 'ar')),
        errors: () => [
          isA<BaseException>().having(
            (s) => s.message,
            'error message',
            contains('Language not supported'),
          ),
        ],
      );
    },
  );
}
