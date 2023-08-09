import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/view/widgets/action_dialog.dart';
import 'package:flutter_sharez/features/send/view/widgets/server_info_box.dart';
import 'package:flutter_sharez/features/send/view/widgets/send_actions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class StartedServerView extends ConsumerWidget {
  final ServerInfo serverInfo;
  const StartedServerView({Key? key, required this.serverInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool?>(
            context: context, builder: (context) => const ActionDialog());
        return result ?? false;
      },
      child: <Widget>[
        Consumer(
          builder: (context, ref, child) {
            final files = ref.watch(selectedFilesPod);
            return "You are currently sharing ${files.length} file"
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
                  onPressed: () {
                    //final sendernotifier = ref.read(sendProvider.notifier);
                    // sendernotifier.addFiles();
                  },
                  child: 'Add more files'.text.make(),
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
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => const FilesBottomsheetView(),
                    // );
                  },
                  child: 'Show files'.text.make(),
                ),
              );
            },
          )
        ].hStack(alignment: MainAxisAlignment.spaceAround).p16(),
        "You can access the server by following infomation"
            .text
            .semiBold
            .makeCentered(),
        QrImageView(
          data: 'fshare:${serverInfo.ip}:${serverInfo.port}',
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
          serverInfo: serverInfo,
        ),
        ServerInfoBox(
          serverInfo: serverInfo,
        ),
      ].vStack().scrollVertical().safeArea(),
    );
  }
}
