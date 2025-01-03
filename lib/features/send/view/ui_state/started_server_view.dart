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

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class StartedServerView extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const StartedServerView({super.key, required this.serverInfo});

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
    final t = ref.watch(translationsPod);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          final dialogResult = await showDialog<bool?>(
            context: context,
            builder: (context) => const ActionDialog(),
          );
          if (dialogResult != null && dialogResult == true) {
            completerbool.complete(true);
          }
        }
      },
      child: <Widget>[
        Consumer(
          builder: (context, ref, child) {
            final files = ref.watch(selectedFilesPod);
            return t
                .share_files(n: files.length)
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
                  child: t.add_more_files.text.make(),
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
                  child: t.show_files.text.make(),
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
          label: t.share_on_web.text.bold.make(),
          icon: const Icon(Icons.public),
        ).p8(),
        t.share_info_message.text.semiBold.makeCentered(),
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
