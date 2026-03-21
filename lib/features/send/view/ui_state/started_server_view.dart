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
import 'package:lottie/lottie.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 850;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await ref.read(autorouterProvider).navigate(
          StopServerActionDialogRoute(
            onYesClicked: () {},
          ),
        );
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderCard(theme, t, isWide),
                  const SizedBox(height: 12),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildQrCard(theme, t)),
                        const SizedBox(width: 12),
                        Expanded(flex: 3, child: _buildSecondaryActions()),
                      ],
                    )
                  else ...[
                    _buildQrCard(theme, t),
                    const SizedBox(height: 12),
                    _buildSecondaryActions(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(ShadThemeData theme, dynamic t, bool isWide) {
    return Consumer(builder: (context, ref, child) {
      final files = ref.watch(selectedFilesPod);
      final isEmpty = files.isEmpty;

      return ShadCard(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: isWide && isEmpty
            ? Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Lottie.asset(
                      'assets/anim/starting_rocket.json',
                      repeat: true,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ready to Share!",
                          style: theme.textTheme.h3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Your local portal is live as: ${widget.serverInfo.deviceName}",
                          style: theme.textTheme.muted,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        ShadButton(
                          onPressed: selectFiles,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.plus, size: 18),
                              const SizedBox(width: 8),
                              Text(t.addFiles),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  if (isEmpty) ...[
                    SizedBox(
                      height: 130,
                      child: Lottie.asset(
                        'assets/anim/starting_rocket.json',
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Ready to Share!",
                      style: theme.textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.serverInfo.deviceName,
                      style: theme.textTheme.large.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ShadButton(
                      width: double.infinity,
                      onPressed: selectFiles,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.plus, size: 18),
                          const SizedBox(width: 8),
                          Text(t.addFiles),
                        ],
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LucideIcons.fileBox,
                            size: 24,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.shareFiles(n: files.length),
                                style: theme.textTheme.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.serverInfo.deviceName,
                                style: theme.textTheme.muted,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        children: [
                          Flexible(
                            child: ShadButton(
                              width: double.infinity,
                              onPressed: selectFiles,
                              child: const Icon(LucideIcons.plus, size: 18),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 2,
                            child: ShadButton.outline(
                              width: double.infinity,
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
                              child: Text(
                                t.showFiles,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ],
              ),
      );
    });
  }

  Widget _buildQrCard(ShadThemeData theme, dynamic t) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            t.shareInfoMessage,
            style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: QrImageView(
              data: 'fshare:${widget.serverInfo.ip}:${widget.serverInfo.port}',
              version: QrVersions.auto,
              size: 140,
              gapless: true,
              embeddedImage: const AssetImage(
                  'assets/images/logo/ic_launcher_adaptive_fore.png'),
              embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(30, 30)),
              dataModuleStyle: const QrDataModuleStyle(color: Colors.black),
              eyeStyle: const QrEyeStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          ShadButton.outline(
            width: double.infinity,
            size: ShadButtonSize.sm,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.globe, size: 14),
                const SizedBox(width: 6),
                Text(
                  t.shareOnWeb,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryActions() {
    return Column(
      children: [
        ServerInfoBox(serverInfo: widget.serverInfo),
        const SizedBox(height: 12),
        SendActions(serverInfo: widget.serverInfo),
      ],
    );
  }
}
