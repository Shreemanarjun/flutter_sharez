import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_sharez/translation_pod.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        elevation: 9,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.info,
                      size: 16,
                    ),
                  ),
                  Center(
                    child: Text(
                      t.wifiWarning,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.link_outlined),
                label: Text(t.ipLablel),
              ),
              title: Center(
                child: Text(
                  widget.serverInfo.ip,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Tooltip(
                  message: t.copyIpTooltip,
                  child: ElevatedButton(
                    onPressed: () async => await copyToClipBoard(
                      text: widget.serverInfo.ip,
                      message: t.copyIpMessage,
                    ),
                    child: const Icon(Icons.content_copy_outlined),
                  ),
                ),
              ),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.settings_input_component_outlined),
                label: Text(t.portLabel),
              ),
              title: Center(
                child: Text(
                  widget.serverInfo.port.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Tooltip(
                  message: t.portTolltip,
                  child: ElevatedButton(
                    onPressed: () async => await copyToClipBoard(
                      text: widget.serverInfo.port.toString(),
                      message: t.portMessage,
                    ),
                    child: const Icon(Icons.content_copy_outlined),
                  ),
                ),
              ),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: TextButton.icon(
                onPressed: () {},
                icon: OSLogo(os: widget.serverInfo.os),
                label: Text(t.osLable),
              ),
              title: Center(
                child: Text(
                  widget.serverInfo.os,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Tooltip(
                  message: t.osLable,
                  child: ElevatedButton(
                    onPressed: () async => await copyToClipBoard(
                      text: widget.serverInfo.os.toString(),
                      message: t.osCopyMessage,
                    ),
                    child: const Icon(Icons.content_copy_outlined),
                  ),
                ),
              ),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info),
                label: Text(t.osVersionLabel),
              ),
              title: Center(
                child: Text(
                  widget.serverInfo.version,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Tooltip(
                  message: t.osVersiontooltip,
                  child: ElevatedButton(
                    onPressed: () async => await copyToClipBoard(
                      text: widget.serverInfo.os.toString(),
                      message: t.osVersionMsg,
                    ),
                    child: const Icon(Icons.content_copy_outlined),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
