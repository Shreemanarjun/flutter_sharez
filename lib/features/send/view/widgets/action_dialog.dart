import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class ActionDialog extends ConsumerStatefulWidget {
  const ActionDialog({
    super.key,
  });

  @override
  ConsumerState<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends ConsumerState<ActionDialog> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop<bool>(true);
            await ref.read(senderServicePod).stopServer();
          },
          child: LocaleKeys.dialogActionYes
              .tr()
              .text
              .isIntrinsic
              .green500
              .bold
              .make(),
        ).p4(),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            completer.complete(false);
          },
          child: LocaleKeys.dialogActionNo
              .tr()
              .text
              .isIntrinsic
              .red500
              .bold
              .make(),
        ).p4(),
      ],
      title: LocaleKeys.stopSharingTitle.tr().text.center.isIntrinsic.make(),
    );
  }
}
