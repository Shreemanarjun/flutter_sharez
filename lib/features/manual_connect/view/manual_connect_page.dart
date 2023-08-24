import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ManualConnectPage extends StatefulWidget {
  const ManualConnectPage({Key? key}) : super(key: key);

  @override
  State<ManualConnectPage> createState() => _ManualConnectPageState();
}

class _ManualConnectPageState extends State<ManualConnectPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      alignment: Alignment.center,
      content: <Widget>[
        "Enter IP".text.isIntrinsic.make().p2(),
        TextFormField(),
        "Enter Port".text.isIntrinsic.make().p2(),
        TextFormField().p4(),
      ].vStack(
        crossAlignment: CrossAxisAlignment.start,
        alignment: MainAxisAlignment.spaceAround,
        axisSize: MainAxisSize.min,
      ),
      actions: [
        CupertinoButton(
          onPressed: () {},
          child: "Connect".text.isIntrinsic.make(),
        )
      ],
    );
  }
}
