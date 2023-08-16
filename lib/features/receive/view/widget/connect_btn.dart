import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ConnectBtn extends StatelessWidget {
  const ConnectBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.subdirectory_arrow_right),
      label: "Connect".text.make(),
    );
  }
}
