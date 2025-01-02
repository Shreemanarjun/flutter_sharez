import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ManualConnectPage extends ConsumerStatefulWidget {
  const ManualConnectPage({super.key});

  @override
  ConsumerState<ManualConnectPage> createState() => _ManualConnectPageState();
}

class _ManualConnectPageState extends ConsumerState<ManualConnectPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return AlertDialog(
      alignment: Alignment.center,
      content: FormBuilder(
        key: _formKey,
        child: <Widget>[
          FormBuilderTextField(
            name: 'ip',
            decoration: InputDecoration(
              labelText: t.enterIp,
            ),
          ).p4(),
          FormBuilderTextField(
            name: 'port',
            decoration: InputDecoration(
              labelText: t.enterPort,
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
          child: t.connect.text.isIntrinsic.make(),
        )
      ],
    );
  }
}
