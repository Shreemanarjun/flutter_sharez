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
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final theme = ShadTheme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final files = ref.watch(selectedFilesPod);
                  return ShadCard(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LucideIcons.fileBox,
                            size: 32,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          t.shareFiles(n: files.length),
                          style: theme.textTheme.h3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ShadButton(
                                onPressed: selectFiles,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(LucideIcons.plus, size: 16),
                                    const SizedBox(width: 8),
                                    Text(t.addMoreFiles),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ShadButton.outline(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(LucideIcons.list, size: 16),
                                    const SizedBox(width: 8),
                                    Text(t.showFiles),
                                  ],
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    enableDrag: true,
                                    showDragHandle: true,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) =>
                                        const FilesBottomsheetView(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ShadCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      t.shareInfoMessage,
                      style: theme.textTheme.large.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]),
                      child: QrImageView(
                        data:
                            'fshare:${widget.serverInfo.ip}:${widget.serverInfo.port}',
                        version: QrVersions.auto,
                        size: 160,
                        gapless: true,
                        embeddedImageStyle:
                            const QrEmbeddedImageStyle(size: Size(120, 120)),
                        embeddedImage: const AssetImage(
                            'assets/images/logo/ic_launcher_adaptive_fore.png'),
                        constrainErrorBounds: true,
                        dataModuleStyle: QrDataModuleStyle(color: Colors.black),
                        eyeStyle: QrEyeStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ShadButton.outline(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.globe, size: 16),
                            const SizedBox(width: 8),
                            Text(t.shareOnWeb),
                          ],
                        ),
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ServerInfoBox(
                serverInfo: widget.serverInfo,
              ),
              const SizedBox(height: 16),
              SendActions(
                serverInfo: widget.serverInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
