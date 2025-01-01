import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';

import 'package:velocity_x/velocity_x.dart';

///This widget can be used to change the local in a popup
class AppLocalePopUp extends ConsumerWidget {
  const AppLocalePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = LocaleSettings.currentLocale;
    final localeName = context.t["locale_${locale.languageCode}"].toString();

    return PopupMenuButton<AppLocale>(
        initialValue: locale,
        child: localeName.text.extraBlack.make(),
        //  icon: const Icon(Icons.translate),
        // Callback that sets the selected popup menu item.
        onSelected: (locale) {
          LocaleSettings.setLocale(locale);
        },
        itemBuilder: (BuildContext context) => AppLocale.values.map(
              (e) {
                return PopupMenuItem<AppLocale>(
                  value: e,
                  child: e == locale
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

class SelectedLocaleItem extends StatelessWidget {
  const SelectedLocaleItem({
    super.key,
    required this.locale,
  });
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final localeName = context.t["locale_${locale.languageCode}"].toString();
    return <Widget>[
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
      localeName.text.bold.isIntrinsic.make(),
    ].hStack();
  }
}

class UnselectedLocaleItem extends StatelessWidget {
  const UnselectedLocaleItem({
    super.key,
    required this.locale,
  });
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final localeName = context.t["locale_${locale.languageCode}"].toString();
    return Localizations.override(
      context: context,
      locale: locale,
      child: localeName.text.bold.isIntrinsic.make(),
    );
  }
}
