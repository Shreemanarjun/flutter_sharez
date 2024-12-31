import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:velocity_x/velocity_x.dart';

///This widget can be used to change the local in a popup
class AppLocalePopUp extends ConsumerWidget {
  const AppLocalePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Locale>(
        initialValue: context.locale,
        child: "locale_${context.locale}".tr().text.extraBlack.make(),
        //  icon: const Icon(Icons.translate),
        // Callback that sets the selected popup menu item.
        onSelected: (locale) {
          context.setLocale(locale);
        },
        itemBuilder: (BuildContext context) => context.supportedLocales.map(
              (e) {
                return PopupMenuItem<Locale>(
                  value: e,
                  child: e == context.locale
                      ? SelectedLocaleItem(
                          locale: e,
                          key: ValueKey('selected ${e.languageCode}'),
                        )
                      : UnselectedLocaleItem(
                          locale: e,
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
    return <Widget>[
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
      "locale_$locale".tr().text.bold.isIntrinsic.make(),
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
    return Localizations.override(
      context: context,
      locale: locale,
      child: "locale_$locale".tr().text.bold.isIntrinsic.make(),
    );
  }
}
