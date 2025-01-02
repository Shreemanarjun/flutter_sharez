import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class ServerInfoBox extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const ServerInfoBox({super.key, required this.serverInfo});

  @override
  ConsumerState<ServerInfoBox> createState() => _ServerInfoBoxState();
}

class _ServerInfoBoxState extends ConsumerState<ServerInfoBox>
    with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        <Widget>[
          const Icon(
            Icons.info,
            size: 16,
          ).p4(),
          t.wifiWarning.text.sm.semiBold.makeCentered(),
        ]
            .hStack(
              alignment: MainAxisAlignment.center,
            )
            .py12(),
        ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.link_outlined),
            label: t.ipLablel.text.make(),
          ),
          title: widget.serverInfo.ip.text.bold.center.make(),
          trailing: Tooltip(
            message: t.copyIpTooltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.ip,
                message: t.copyIpMessage,
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
        ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.settings_input_component_outlined),
            label: t.portLabel.text.make(),
          ),
          title: widget.serverInfo.port.text.bold.center.make(),
          trailing: Tooltip(
            message: t.portTolltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.port.toString(),
                message: t.portMessage,
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
        ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: TextButton.icon(
            onPressed: () {},
            icon: OSLogo(os: widget.serverInfo.os),
            label: t.osLable.text.make(),
          ),
          title: widget.serverInfo.os.text.bold.center.make(),
          trailing: Tooltip(
            message: t.osLable,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: t.osCopyMessage,
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
        ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.info),
            label: t.osVersionLabel.text.make(),
          ),
          title: widget.serverInfo.version.text.bold.sm.center.make(),
          trailing: Tooltip(
            message: t.osVersiontooltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: t.osVersionMsg,
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
      ],
    ).card.elevation(9).make().px4();
  }
}
