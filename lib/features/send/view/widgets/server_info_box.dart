import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:velocity_x/velocity_x.dart';

class ServerInfoBox extends StatefulWidget {
  final ServerInfo serverInfo;
  const ServerInfoBox({Key? key, required this.serverInfo}) : super(key: key);

  @override
  State<ServerInfoBox> createState() => _ServerInfoBoxState();
}

class _ServerInfoBoxState extends State<ServerInfoBox> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        <Widget>[
          const Icon(
            Icons.info,
            size: 16,
          ).p4(),
          context.l10n.wifiWarning.text.sm.semiBold.makeCentered(),
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
            label: context.l10n.ipLablel.text.make(),
          ),
          title: widget.serverInfo.ip.text.bold.center.make(),
          trailing: Tooltip(
            message: context.l10n.copyIpTooltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.ip,
                message: context.l10n.copyIpMessage,
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
            label: context.l10n.portLabel.text.make(),
          ),
          title: widget.serverInfo.port.text.bold.center.make(),
          trailing: Tooltip(
            message: context.l10n.portTolltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.port.toString(),
                message: context.l10n.portMessage,
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
            label: context.l10n.osLable.text.make(),
          ),
          title: widget.serverInfo.os.text.bold.center.make(),
          trailing: Tooltip(
            message: context.l10n.osLable,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: context.l10n.osCopyMessage,
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
            label: context.l10n.osVersionLabel.text.make(),
          ),
          title: widget.serverInfo.version.text.bold.sm.center.make(),
          trailing: Tooltip(
            message: context.l10n.osVersiontooltip,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: context.l10n.osVersionMsg,
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
      ],
    ).card.elevation(9).make().px4();
  }
}
