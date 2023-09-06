import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
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
    return AlertDialog(
      alignment: Alignment.center,
      content: <Widget>[
        context.l10n.enterIp.text.isIntrinsic.make().p2(),
        TextFormField(),
        context.l10n.enterPort.text.isIntrinsic.make().p2(),
        TextFormField().p4(),
      ].vStack(
        crossAlignment: CrossAxisAlignment.start,
        alignment: MainAxisAlignment.spaceAround,
        axisSize: MainAxisSize.min,
      ),
      actions: [
        CupertinoButton(
          onPressed: () {},
          child: context.l10n.connect.text.isIntrinsic.make(),
        )
      ],
    );
  }
}
