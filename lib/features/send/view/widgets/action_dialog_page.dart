import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class StopServerActionDialogPage extends ConsumerStatefulWidget {
  final VoidCallback onYesClicked;
  const StopServerActionDialogPage({
    super.key,
    required this.onYesClicked,
  });

  @override
  ConsumerState<StopServerActionDialogPage> createState() =>
      _StopServerActionDialogState();
}

class _StopServerActionDialogState
    extends ConsumerState<StopServerActionDialogPage> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ref.read(senderServicePod).stopServer();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
            widget.onYesClicked();
          },
          child: t.dialogActionYes.text.isIntrinsic.green500.bold.make(),
        ).p4(),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            completer.complete(false);
          },
          child: t.dialogActionNo.text.isIntrinsic.red500.bold.make(),
        ).p4(),
      ],
      title: t.stopSharingTitle.text.center.isIntrinsic.make(),
    );
  }
}
