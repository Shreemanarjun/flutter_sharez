import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/i18n/translations.g.dart';

final translationsPod = StateProvider<Translations>(
  (ref) => throw UnimplementedError(
    "translations not overriden yet",
  ),
  name: 'translationsProvider',
);
