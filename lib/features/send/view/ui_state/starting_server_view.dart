import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartingServerView extends StatelessWidget {
  const StartingServerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      const CircularProgressIndicator.adaptive().p8(),
      "Setting up server to share your files".text.make().objectCenter(),
    ]
        .vStack(
          alignment: MainAxisAlignment.center,
        )
        .safeArea();
  }
}
