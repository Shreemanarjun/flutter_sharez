import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender_service_pod.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class ActionDialog extends ConsumerStatefulWidget {
  const ActionDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends ConsumerState<ActionDialog> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref.read(senderServicePod).stopServer();
            showInfoSnack(child: 'Server Stopped ❌'.text.isIntrinsic.make());
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
              context.back();
            }
          },
          child: 'Yes'.text.isIntrinsic.red500.bold.make(),
        ).p4(),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: 'No'.text.isIntrinsic.green500.bold.make(),
        ).p4(),
      ],
      title: 'Are you sure to stop sharing ?'.text.isIntrinsic.make(),
    );
  }
}
