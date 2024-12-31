import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:velocity_x/velocity_x.dart';

class StartingServerView extends StatelessWidget {
  const StartingServerView({super.key});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      const CircularProgressIndicator.adaptive().p8(),
      LocaleKeys.settingUpServer.tr().text.make().objectCenter(),
    ]
        .vStack(
          alignment: MainAxisAlignment.center,
        )
        .safeArea();
  }
}
