import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final theme = ShadTheme.of(context);
    final webUrl = 'http://${widget.serverInfo.ip}:${widget.serverInfo.port}/web';

    return ShadSheet(
      backgroundColor: theme.colorScheme.background,
      title: Text(t.shareOnWeb),
      description: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          t.shareWebMsg,
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        ShadButton(
          leading: const Icon(LucideIcons.copy, size: 16),
          onPressed: () async => await copyToClipBoard(
            text: webUrl,
            message: t.addressCopiedMsg,
          ),
          child: Text(t.copyAddressTooltip),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: QrImageView(
                data: 'http://${widget.serverInfo.ip}:${widget.serverInfo.port}/web',
                version: QrVersions.auto,
                size: 200,
                gapless: true,
                embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(40, 40)),
                embeddedImage: const AssetImage(
                  'assets/images/logo/ic_launcher_adaptive_fore.png',
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  color: Colors.black,
                ),
                eyeStyle: const QrEyeStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.muted.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.border),
              ),
              child: SelectableText(
                webUrl,
                style: theme.textTheme.p.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
