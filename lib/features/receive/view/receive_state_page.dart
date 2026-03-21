import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/receive/view/widget/connect_btn.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage(
  deferredLoading: true,
)
class ReceiveStatePage extends ConsumerWidget {
  const ReceiveStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Consumer(
        builder: (context, ref, child) {
          final t = ref.watch(translationsPod);
          final okserversAsync = ref.watch(oKServersListProvider);

          return okserversAsync.easyWhen(
            data: (sendermodels) {
              if (sendermodels.isEmpty) {
                return _buildEmptyState(context, ref, t);
              } else {
                return _buildDeviceList(context, ref, sendermodels, t);
              }
            },
            loadingWidget: () => _buildLoadingState(context, t),
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: false,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: ShadButton.outline(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.plus, size: 16),
                      const SizedBox(width: 8),
                      Text(t.manuallyAdd),
                    ],
                  ),
                  onPressed: () {
                    context.navigateTo(const ManualConnectRoute());
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShadButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.qrCode, size: 16),
                      const SizedBox(width: 8),
                      Text(t.qrScan),
                    ],
                  ),
                  onPressed: () {
                    context.navigateTo(const QrScanRoute());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, dynamic t) {
    final theme = ShadTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.wifiOff,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t.noDevicesinNetwork,
            style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Ensure sender is on the same Wi-Fi network.",
            style: theme.textTheme.muted,
          ),
          const SizedBox(height: 32),
          ShadButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.refreshCw, size: 16),
                const SizedBox(width: 8),
                Text(t.rescan),
              ],
            ),
            onPressed: () {
              ref.invalidate(oKServersListProvider);
            },
          ),
          const SizedBox(height: 12),
          Text(
            "OR",
            style: theme.textTheme.muted.copyWith(fontSize: 10),
          ),
          const SizedBox(height: 12),
          ShadCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.wifi,
                        size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text(
                      "No common Wi-Fi?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Ask the sender to start a Hotspot and scan their QR code to join and share at maximum speed.",
                  style: theme.textTheme.muted,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context, dynamic t) {
    final theme = ShadTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t.scanningNetwork,
            style: theme.textTheme.large.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Looking for nearby devices...",
            style: theme.textTheme.muted,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceList(
      BuildContext context, WidgetRef ref, List sendermodels, dynamic t) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            t.foundDevices(n: sendermodels.length),
            style: theme.textTheme.h4.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              color: theme.colorScheme.primary,
              onRefresh: () => ref.refresh(oKServersListProvider.future),
              child: ListView.separated(
                itemCount: sendermodels.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sendermodel = sendermodels[index];
                  return ShadCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: OSLogo(os: sendermodel.os),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sendermodel.deviceName ??
                                    sendermodel.host ??
                                    "${sendermodel.version}",
                                style: theme.textTheme.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                t.receiveShareFiles(
                                    n: sendermodel.filesCount ?? 0),
                                style: theme.textTheme.muted,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${sendermodel.ip}:${sendermodel.port}",
                                style: theme.textTheme.muted
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        ConnectBtn(senderModel: sendermodel),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
