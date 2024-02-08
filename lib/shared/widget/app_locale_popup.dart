import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/pods/locale_pod.dart';
import 'package:velocity_x/velocity_x.dart';

///This widget can be used to change the local in a popup
class AppLocalePopUp extends ConsumerWidget {
  const AppLocalePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Locale>(
        initialValue: AppLocalizations.supportedLocales.first,
        icon: const Icon(Icons.translate),
        // Callback that sets the selected popup menu item.
        onSelected: (locale) {
          ref.read(localePod.notifier).changeLocale(locale: locale);
        },
        itemBuilder: (BuildContext context) =>
            AppLocalizations.supportedLocales.map(
              (e) {
                final currentLocale = ref.watch(localePod);
                return PopupMenuItem<Locale>(
                  value: e,
                  child: e == currentLocale
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
      getLanguageName(locale).text.bold.isIntrinsic.make(),
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
    return getLanguageName(locale).text.bold.isIntrinsic.make();
  }
}

String getLanguageName(Locale e) {
  final languageMap = {
    'en': 'English',
    'es': 'Spanish',
    'or': 'Odia',
    'ar': 'Arabic',
  };
  return languageMap[e.languageCode] ?? 'Unknown language';
}
