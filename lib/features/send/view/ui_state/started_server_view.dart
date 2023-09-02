import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/view/widgets/action_dialog.dart';
import 'package:flutter_sharez/features/send/view/widgets/files_bottomsheet.dart';
import 'package:flutter_sharez/features/send/view/widgets/server_info_box.dart';
import 'package:flutter_sharez/features/send/view/widgets/send_actions.dart';
import 'package:flutter_sharez/features/send/view/widgets/share_on_web.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class StartedServerView extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const StartedServerView({Key? key, required this.serverInfo})
      : super(key: key);

  @override
  ConsumerState<StartedServerView> createState() => _StartedServerViewState();
}

class _StartedServerViewState extends ConsumerState<StartedServerView>
    with GlobalHelper {
  final Completer<bool> completerbool = Completer();

  Future<void> selectFiles() async {
    ref.read(selectedFilesPod.notifier).selectFiles(
      onError: (error) {
        showErrorSnack(child: error.text.isIntrinsic.make());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool?>(
          context: context,
          builder: (context) => const ActionDialog(),
        );
        return (result != null && result == true) ? true : false;
      },
      child: <Widget>[
        Consumer(
          builder: (context, ref, child) {
            final files = ref.watch(selectedFilesPod);
            return context.l10n
                .shareFiles(files.length)
                .text
                .bold
                .lg
                .makeCentered()
                .p8();
          },
        ),
        [
          Consumer(
            builder: (context, ref, child) {
              return Flexible(
                child: ElevatedButton(
                  onPressed: selectFiles,
                  child: context.l10n.addMoreFiles.text.make(),
                ),
              );
            },
          ),
          10.widthBox,
          Consumer(
            builder: (context, ref, child) {
              return Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      enableDrag: true,
                      showDragHandle: true,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => const FilesBottomsheetView(),
                    );
                  },
                  child: context.l10n.showFiles.text.make(),
                ),
              );
            },
          )
        ].hStack(alignment: MainAxisAlignment.spaceAround).p16(),
        ElevatedButton.icon(
          onPressed: () async {
            showModalBottomSheet(
              enableDrag: true,
              showDragHandle: true,
              useSafeArea: true,
              context: context,
              builder: (context) => ShareOnWebSheet(
                serverInfo: widget.serverInfo,
              ),
            );
          },
          label: context.l10n.shareOnWeb.text.bold.make(),
          icon: const Icon(Icons.public),
        ).p8(),
        context.l10n.shareInfoMessage.text.semiBold.makeCentered(),
        QrImageView(
          data: 'fshare:${widget.serverInfo.ip}:${widget.serverInfo.port}',
          version: QrVersions.auto,
          size: 140,
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
        ).p8(),
        SendActions(
          serverInfo: widget.serverInfo,
        ),
        ServerInfoBox(
          serverInfo: widget.serverInfo,
        ),
      ].vStack().scrollVertical().safeArea(),
    );
  }
}
