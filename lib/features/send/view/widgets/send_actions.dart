import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/features/send/view/widgets/action_dialog.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';

import 'package:velocity_x/velocity_x.dart';

class SendActions extends StatefulWidget {
  final ServerInfo serverInfo;
  const SendActions({
    Key? key,
    required this.serverInfo,
  }) : super(key: key);

  @override
  State<SendActions> createState() => _SendActionsState();
}

class _SendActionsState extends State<SendActions> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Tooltip(
          message: 'Copy Address',
          child: ElevatedButton.icon(
            onPressed: () async => await copyToClipBoard(
              text: '${widget.serverInfo.ip}:${widget.serverInfo.port}',
              message: 'Address Copied to Clipboard',
            ),
            icon: const Icon(Icons.content_copy_outlined),
            label: "Copy Address".text.make(),
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
              label: 'Stop Sharing'.text.red500.bold.make(),
              icon: const Icon(Icons.cancel_outlined),
            ).p8();
          },
        ),
      ],
    );
  }
}
