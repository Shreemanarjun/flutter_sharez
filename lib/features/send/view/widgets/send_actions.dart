import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/features/send/view/widgets/action_dialog.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:velocity_x/velocity_x.dart';

class SendActions extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const SendActions({
    super.key,
    required this.serverInfo,
  });

  @override
  ConsumerState<SendActions> createState() => _SendActionsState();
}

class _SendActionsState extends ConsumerState<SendActions> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return Wrap(
      children: [
        Tooltip(
          message: t.copyAddressTooltip,
          child: ElevatedButton.icon(
            onPressed: () async => await copyToClipBoard(
              text: '${widget.serverInfo.ip}:${widget.serverInfo.port}',
              message: t.addressCopiedMsg,
            ),
            icon: const Icon(Icons.content_copy_outlined),
            label: t.copyAddressTooltip.text.make(),
          ),
        ).p8(),
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => const ActionDialog(),
                );
                if (result != null && result == true && context.mounted) {
                  Navigator.pop(context);
                }
              },
              label: t.stopSharing.text.red500.bold.make(),
              icon: const Icon(Icons.cancel_outlined),
            ).p8();
          },
        ),
      ],
    );
  }
}
