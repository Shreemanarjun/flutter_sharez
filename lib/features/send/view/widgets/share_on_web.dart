import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareOnWebSheet extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const ShareOnWebSheet({super.key, required this.serverInfo});

  @override
  ConsumerState<ShareOnWebSheet> createState() => _ShareOnWebSheetState();
}

class _ShareOnWebSheetState extends ConsumerState<ShareOnWebSheet>
    with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QrImageView(
                data:
                    '${widget.serverInfo.ip}:${widget.serverInfo.port}/filepath/web',
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.height * 0.18,
                gapless: true,
                embeddedImageStyle:
                    const QrEmbeddedImageStyle(size: Size(120, 120)),
                embeddedImage: const AssetImage(
                  'assets/images/logo/ic_launcher_adaptive_fore.png',
                ),
                constrainErrorBounds: true,
                dataModuleStyle: QrDataModuleStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                eyeStyle: QrEyeStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Center(
              child: Text(
                t.shareWebMsg,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                '${widget.serverInfo.ip}:${widget.serverInfo.port}/web ',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: t.copyAddressTooltip,
              child: ElevatedButton.icon(
                onPressed: () async => await copyToClipBoard(
                  text:
                      '${widget.serverInfo.ip}:${widget.serverInfo.port}/web ',
                  message: t.addressCopiedMsg,
                ),
                icon: const Icon(Icons.content_copy_outlined),
                label: Text(t.copyAddressTooltip),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
