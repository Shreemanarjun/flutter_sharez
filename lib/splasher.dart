import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/app/view/app.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/features/splash/view/splash_view.dart';

class Splasher extends StatelessWidget {
  const Splasher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: SplashView(
        removeSpalshLoader: true,
        onInitialized: (container) {
          bootstrap(
            () => EasyLocalization(
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
                Locale('or'),
              ],
              fallbackLocale: const Locale('en'),
              path: "assets/translations",
              useOnlyLangCode: true,
              child: const App(),
            ),
            parent: container,
          );
        },
      ),
    );
  }
}
