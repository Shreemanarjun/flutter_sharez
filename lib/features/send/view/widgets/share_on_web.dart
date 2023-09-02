import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class ShareOnWebSheet extends StatefulWidget {
  final ServerInfo serverInfo;
  const ShareOnWebSheet({Key? key, required this.serverInfo}) : super(key: key);

  @override
  State<ShareOnWebSheet> createState() => _ShareOnWebSheetState();
}

class _ShareOnWebSheetState extends State<ShareOnWebSheet> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
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
      context.l10n.shareWebMsg.text.xl.bold.center.make().px4(),
      '${widget.serverInfo.ip}:${widget.serverInfo.port}/web '
          .text
          .extraBold
          .green500
          .lg
          .makeCentered()
          .py8(),
      Tooltip(
        message: context.l10n.copyAddressTooltip,
        child: ElevatedButton.icon(
          onPressed: () async => await copyToClipBoard(
            text: '${widget.serverInfo.ip}:${widget.serverInfo.port}/web ',
            message: context.l10n.addressCopiedMsg,
          ),
          icon: const Icon(Icons.content_copy_outlined),
          label: context.l10n.copyAddressTooltip.text.make(),
        ),
      ).p8(),
    ].vStack().whFull(context);
  }
}
