import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
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
  final spacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.link_outlined),
            label: "IP".text.make(),
          ),
          title: widget.serverInfo.ip.text.bold.center.make(),
          trailing: Tooltip(
            message: 'Copy IP',
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.ip,
                message: 'IP Copied to Clipboard',
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
            label: "Port".text.make(),
          ),
          title: widget.serverInfo.port.text.bold.center.make(),
          trailing: Tooltip(
            message: 'Copy Port',
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.port.toString(),
                message: 'Port Copied to Clipboard',
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
            label: "OS Name".text.make(),
          ),
          title: widget.serverInfo.os.text.bold.center.make(),
          trailing: Tooltip(
            message: 'Copy OS Name',
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: 'OS name Copied to Clipboard',
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
            label: "OS Version".text.make(),
          ),
          title: widget.serverInfo.version.text.bold.sm.center.make(),
          trailing: Tooltip(
            message: 'Copy OS Version',
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: 'OS version Copied to Clipboard',
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
      ],
    ).card.elevation(9).make().px4();
  }
}
