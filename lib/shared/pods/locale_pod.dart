import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';

import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';

///This Notifier class used to get current locale and change local in DB
class LocaleNotifier extends Notifier<Locale> {
  final _localeBoxKey = 'locale';

  @override
  Locale build() {
    final locale = ref.watch(appStorageProvider).get(key: _localeBoxKey);

    if (locale != null) {
      return AppLocaleUtils.supportedLocales
          .where((element) => element.languageCode == locale)
          .map((e) => Locale(e.languageCode))
          .first;
    } else {
      return AppLocaleUtils.supportedLocales.first;
    }
  }

  Future<void> changeLocale({required Locale locale}) async {
    final isSupported = AppLocaleUtils.supportedLocales.contains(locale);
    if (isSupported) {
      state = locale;
      await ref.read(appStorageProvider).put(
            key: _localeBoxKey,
            value: locale.languageCode,
          );
    } else {
      throw BaseException(message: 'Language not supported');
    }
  }
}

final localePod = NotifierProvider.autoDispose<LocaleNotifier, Locale>(
  LocaleNotifier.new,
  name: 'localePod',
);
