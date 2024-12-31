import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:velocity_x/velocity_x.dart';

class ServerInfoBox extends StatefulWidget {
  final ServerInfo serverInfo;
  const ServerInfoBox({super.key, required this.serverInfo});

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
          LocaleKeys.wifiWarning.tr().text.sm.semiBold.makeCentered(),
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
            label: LocaleKeys.ipLablel.tr().text.make(),
          ),
          title: widget.serverInfo.ip.text.bold.center.make(),
          trailing: Tooltip(
            message: LocaleKeys.copyIpTooltip.tr(),
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.ip,
                message: LocaleKeys.copyIpMessage.tr(),
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
            label: LocaleKeys.portLabel.tr().text.make(),
          ),
          title: widget.serverInfo.port.text.bold.center.make(),
          trailing: Tooltip(
            message: LocaleKeys.portTolltip.tr(),
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.port.toString(),
                message: LocaleKeys.portMessage.tr(),
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
            label: LocaleKeys.osLable.text.make(),
          ),
          title: widget.serverInfo.os.text.bold.center.make(),
          trailing: Tooltip(
            message: LocaleKeys.osLable,
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: LocaleKeys.osCopyMessage.tr(),
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
            label: LocaleKeys.osVersionLabel.tr().text.make(),
          ),
          title: widget.serverInfo.version.text.bold.sm.center.make(),
          trailing: Tooltip(
            message: LocaleKeys.osVersiontooltip.tr(),
            child: ElevatedButton(
              onPressed: () async => await copyToClipBoard(
                text: widget.serverInfo.os.toString(),
                message: LocaleKeys.osVersionMsg.tr(),
              ),
              child: const Icon(Icons.content_copy_outlined),
            ),
          ).px4(),
        ),
      ],
    ).card.elevation(9).make().px4();
  }
}
