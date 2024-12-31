import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

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
              labelText: LocaleKeys.enterIp.tr(),
            ),
          ).p4(),
          FormBuilderTextField(
            name: 'port',
            decoration: InputDecoration(
              labelText: LocaleKeys.enterPort.tr(),
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
          child: LocaleKeys.connect.tr().text.isIntrinsic.make(),
        )
      ],
    );
  }
}
