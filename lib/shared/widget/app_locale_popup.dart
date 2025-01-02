import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';

import 'package:flutter_sharez/translation_pod.dart';
import 'package:slang/overrides.dart';

import 'package:velocity_x/velocity_x.dart';

///This widget can be used to change the local in a popup
class AppLocalePopUp extends ConsumerWidget {
  const AppLocalePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final curentlocale = t.$meta.locale;
    final localeName = t["locale_${curentlocale.languageCode}"].toString();

    return PopupMenuButton<AppLocale>(
        initialValue: AppLocaleUtils.parse(curentlocale.languageCode),
        child: localeName.text.extraBlack.make(),
        //  icon: const Icon(Icons.translate),
        // Callback that sets the selected popup menu item.
        onSelected: (locale) async {
          final update = switch (locale) {
            AppLocale.en => await AppLocale.en.build(),
            AppLocale.es => await AppLocale.es.build(),
            AppLocale.or => await AppLocale.or.build(),
          };
          ref.read(translationsPod.notifier).update(
                (state) => update,
              );
        },
        itemBuilder: (BuildContext context) => AppLocale.values.map(
              (e) {
                return PopupMenuItem<AppLocale>(
                  value: e,
                  child: e.languageCode == curentlocale.languageCode
                      ? SelectedLocaleItem(
                          locale: e.flutterLocale,
                          key: ValueKey('selected ${e.languageCode}'),
                        )
                      : UnselectedLocaleItem(
                          locale: e.flutterLocale,
                          key: ValueKey('unselected ${e.languageCode}'),
                        ),
                );
              },
            ).toList());
  }
}

class SelectedLocaleItem extends ConsumerWidget {
  const SelectedLocaleItem({
    super.key,
    required this.locale,
  });
  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final localeName = t["locale_${locale.languageCode}"].toString();
    return <Widget>[
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
      localeName.text.bold.isIntrinsic.make(),
    ].hStack();
  }
}

class UnselectedLocaleItem extends ConsumerWidget {
  const UnselectedLocaleItem({
    super.key,
    required this.locale,
  });
  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final localeName = t["locale_${locale.languageCode}"].toString();
    return Localizations.override(
      context: context,
      locale: locale,
      child: localeName.text.bold.isIntrinsic.make(),
    );
  }
}
