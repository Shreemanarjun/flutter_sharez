import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return <Widget>[
      QrImageView(
        data: '${widget.serverInfo.ip}:${widget.serverInfo.port}/filepath/web',
        version: QrVersions.auto,
        size: context.safePercentHeight * 18,
        gapless: true,
        embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(120, 120)),
        embeddedImage: const AssetImage(
          'assets/images/logo/ic_launcher_adaptive_fore.png',
        ),
        constrainErrorBounds: true,
        dataModuleStyle: QrDataModuleStyle(
          color: context.colors.primary,
        ),
        eyeStyle: QrEyeStyle(
          color: context.colors.primary,
        ),
      ).p8().flexible(),
      t.shareWebMsg.text.xl.bold.center.make().px4(),
      '${widget.serverInfo.ip}:${widget.serverInfo.port}/web '
          .text
          .extraBold
          .green500
          .lg
          .makeCentered()
          .py8(),
      Tooltip(
        message: t.copyAddressTooltip,
        child: ElevatedButton.icon(
          onPressed: () async => await copyToClipBoard(
            text: '${widget.serverInfo.ip}:${widget.serverInfo.port}/web ',
            message: t.addressCopiedMsg,
          ),
          icon: const Icon(Icons.content_copy_outlined),
          label: t.copyAddressTooltip.text.make(),
        ),
      ).p8(),
    ].vStack().whFull(context);
  }
}
