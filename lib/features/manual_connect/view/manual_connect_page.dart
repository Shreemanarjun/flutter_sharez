import 'package:auto_route/auto_route.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ManualConnectPage extends StatefulWidget {
  const ManualConnectPage({super.key});

  @override
  State<ManualConnectPage> createState() => _ManualConnectPageState();
}

class _ManualConnectPageState extends State<ManualConnectPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: FormBuilder(
        key: _formKey,
        child: <Widget>[
          FormBuilderTextField(
            name: 'ip',
            decoration: InputDecoration(
              labelText: context.t.enterIp,
            ),
          ).p4(),
          FormBuilderTextField(
            name: 'port',
            decoration: InputDecoration(
              labelText: context.t.enterPort,
            ),
          ).p4(),
        ].vStack(
          crossAlignment: CrossAxisAlignment.start,
          alignment: MainAxisAlignment.spaceAround,
          axisSize: MainAxisSize.min,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: context.t.connect.text.isIntrinsic.make(),
        )
      ],
    );
  }
}
