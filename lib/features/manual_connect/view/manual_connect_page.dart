import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_sharez/translation_pod.dart';

@RoutePage()
class ManualConnectPage extends ConsumerStatefulWidget {
  const ManualConnectPage({super.key});

  @override
  ConsumerState<ManualConnectPage> createState() => _ManualConnectPageState();
}

class _ManualConnectPageState extends ConsumerState<ManualConnectPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return AlertDialog(
      alignment: Alignment.center,
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: FormBuilderTextField(
                name: 'ip',
                decoration: InputDecoration(
                  labelText: t.enterIp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: FormBuilderTextField(
                name: 'port',
                decoration: InputDecoration(
                  labelText: t.enterPort,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: Text(t.connect),
        )
      ],
    );
  }
}
