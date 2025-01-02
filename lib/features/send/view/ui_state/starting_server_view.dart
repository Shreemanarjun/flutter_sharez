import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:velocity_x/velocity_x.dart';

class StartingServerView extends ConsumerWidget {
  const StartingServerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return <Widget>[
      const CircularProgressIndicator.adaptive().p8(),
      t.settingUpServer.text.make().objectCenter(),
    ]
        .vStack(
          alignment: MainAxisAlignment.center,
        )
        .safeArea();
  }
}
