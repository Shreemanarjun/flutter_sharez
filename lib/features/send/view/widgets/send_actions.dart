import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';

import 'package:flutter_sharez/data/model/server_info.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Tooltip(
            message: t.copyAddressTooltip,
            child: ElevatedButton.icon(
              onPressed: () async => await copyToClipBoard(
                text: '${widget.serverInfo.ip}:${widget.serverInfo.port}',
                message: t.addressCopiedMsg,
              ),
              icon: const Icon(Icons.content_copy_outlined),
              label: Text(t.copyAddressTooltip),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(autorouterProvider).navigate(
                    StopServerActionDialogRoute(
                      onYesClicked: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                label: Text(
                  t.stopSharing,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.cancel_outlined),
              ),
            );
          },
        ),
      ],
    );
  }
}
