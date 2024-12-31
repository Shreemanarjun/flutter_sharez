import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class ShareOnWebSheet extends StatefulWidget {
  final ServerInfo serverInfo;
  const ShareOnWebSheet({super.key, required this.serverInfo});

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
      LocaleKeys.shareWebMsg.tr().text.xl.bold.center.make().px4(),
      '${widget.serverInfo.ip}:${widget.serverInfo.port}/web '
          .text
          .extraBold
          .green500
          .lg
          .makeCentered()
          .py8(),
      Tooltip(
        message: LocaleKeys.copyAddressTooltip.tr(),
        child: ElevatedButton.icon(
          onPressed: () async => await copyToClipBoard(
            text: '${widget.serverInfo.ip}:${widget.serverInfo.port}/web ',
            message: LocaleKeys.addressCopiedMsg.tr(),
          ),
          icon: const Icon(Icons.content_copy_outlined),
          label: LocaleKeys.copyAddressTooltip.tr().text.make(),
        ),
      ).p8(),
    ].vStack().whFull(context);
  }
}
