/// Generated file. Do not edit.
///
/// Source: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 3
/// Strings: 207 (69 per locale)
///
/// Built on 2025-01-03 at 16:54 UTC

// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'package:slang/overrides.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

import 'translations_es.g.dart' deferred as l_es;
import 'translations_or.g.dart' deferred as l_or;
part 'translations_en.g.dart';

/// Generated by the "Translation Overrides" feature.
/// This config is needed to recreate the translation model exactly
/// the same way as this file was created.
final _buildConfig = BuildModelConfig(
  fallbackStrategy: FallbackStrategy.baseLocaleEmptyString,
  keyCase: CaseStyle.snake,
  keyMapCase: CaseStyle.camel,
  paramCase: CaseStyle.pascal,
  sanitization: SanitizationConfig(enabled: true, prefix: 'k', caseStyle: CaseStyle.camel),
  stringInterpolation: StringInterpolation.doubleBraces,
  maps: ['error.codes', 'category', 'iconNames'],
  pluralAuto: PluralAuto.cardinal,
  pluralParameter: 'n',
  pluralCardinal: ['someKey.apple'],
  pluralOrdinal: ['someKey.place'],
  contexts: [
    ContextType(enumName: 'GenderContext', defaultParameter: 'gender', generateEnum: true),
  ],
  interfaces: [], // currently not supported
);

/// Supported locales.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en'),
  es(languageCode: 'es'),
  or(languageCode: 'or');

  const AppLocale({
    required this.languageCode,
    this.scriptCode, // ignore: unused_element
    this.countryCode, // ignore: unused_element
  });

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;

  @override
  Future<Translations> build({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) async {
    switch (this) {
      case AppLocale.en:
        return TranslationsEn(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
      case AppLocale.es:
        await l_es.loadLibrary();
        return l_es.TranslationsEs(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
      case AppLocale.or:
        await l_or.loadLibrary();
        return l_or.TranslationsOr(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
    }
  }

  @override
  Translations buildSync({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) {
    switch (this) {
      case AppLocale.en:
        return TranslationsEn(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
      case AppLocale.es:
        return l_es.TranslationsEs(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
      case AppLocale.or:
        return l_or.TranslationsOr(
          overrides: overrides,
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        );
    }
  }
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
  AppLocaleUtils._()
      : super(
          baseLocale: AppLocale.en,
          locales: AppLocale.values,
          buildConfig: _buildConfig,
        );

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) =>
      instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
  static AppLocale findDeviceLocale() => instance.findDeviceLocale();
  static List<Locale> get supportedLocales => instance.supportedLocales;
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
  static Future<Translations> buildWithOverrides(
          {required AppLocale locale,
          required FileType fileType,
          required String content,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.buildWithOverrides(
          locale: locale, fileType: fileType, content: content, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
  static Future<Translations> buildWithOverridesFromMap(
          {required AppLocale locale,
          required bool isFlatMap,
          required Map map,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.buildWithOverridesFromMap(
          locale: locale, isFlatMap: isFlatMap, map: map, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
  static Translations buildWithOverridesSync(
          {required AppLocale locale,
          required FileType fileType,
          required String content,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.buildWithOverridesSync(
          locale: locale, fileType: fileType, content: content, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
  static Translations buildWithOverridesFromMapSync(
          {required AppLocale locale,
          required bool isFlatMap,
          required Map map,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.buildWithOverridesFromMapSync(
          locale: locale, isFlatMap: isFlatMap, map: map, cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);
}

// interfaces generated as mixins

mixin PageData2 {
  String get title;
  String? get content => null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PageData2) return false;

    final fields = $fields;
    final otherFields = other.$fields;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i] != otherFields[i]) return false;
    }

    return true;
  }

  @override
  int get hashCode {
    final fields = $fields;
    int result = fields.first.hashCode;
    for (final element in fields.skip(1)) {
      result *= element.hashCode;
    }

    return result;
  }

  List<Object?> get $fields => [
        title,
        content,
      ];
}
