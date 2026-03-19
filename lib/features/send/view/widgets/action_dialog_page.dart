import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';

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
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () async {
              await ref.read(senderServicePod).stopServer();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
              widget.onYesClicked();
            },
            child: Text(
              t.dialogActionYes,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(false);
            },
            child: Text(
              t.dialogActionNo,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      title: Center(
        child: Text(t.stopSharingTitle),
      ),
    );
  }
}
