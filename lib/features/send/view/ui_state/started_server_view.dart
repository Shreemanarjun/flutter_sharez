import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/view/widgets/files_bottomsheet.dart';
import 'package:flutter_sharez/features/send/view/widgets/server_info_box.dart';
import 'package:flutter_sharez/features/send/view/widgets/send_actions.dart';
import 'package:flutter_sharez/features/send/view/widgets/share_on_web.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        showErrorSnack(
          child: Text(
            error,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        );
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
          return;
        }
        await ref.read(autorouterProvider).navigate(
          StopServerActionDialogRoute(
            onYesClicked: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final files = ref.watch(selectedFilesPod);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        t.shareFiles(n: files.length),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: selectFiles,
                        child: Text(t.addMoreFiles),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
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
                        child: Text(t.showFiles),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
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
                  label: Text(
                    t.shareOnWeb,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.public),
                ),
              ),
              Center(
                child: Text(
                  t.shareInfoMessage,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QrImageView(
                  data:
                      'fshare:${widget.serverInfo.ip}:${widget.serverInfo.port}',
                  version: QrVersions.auto,
                  size: 140,
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
              SendActions(
                serverInfo: widget.serverInfo,
              ),
              ServerInfoBox(
                serverInfo: widget.serverInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
