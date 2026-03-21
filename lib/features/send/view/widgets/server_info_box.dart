import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ServerInfoBox extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const ServerInfoBox({super.key, required this.serverInfo});

  @override
  ConsumerState<ServerInfoBox> createState() => _ServerInfoBoxState();
}

class _ServerInfoBoxState extends ConsumerState<ServerInfoBox>
    with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(16),
      title: Row(
        children: [
          Icon(LucideIcons.info, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.shareInfoMessage,
              style: theme.textTheme.large,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      description: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          t.wifiWarning,
          style: theme.textTheme.muted,
          overflow: TextOverflow.visible,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: LucideIcons.smartphone,
            label: "Device Name",
            value: widget.serverInfo.deviceName,
            copyText: widget.serverInfo.deviceName,
            copyMessage: "Device name copied",
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final useGrid = constraints.maxWidth > 500;
              if (useGrid) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 4.5,
                  children: _buildResponsiveItems(context, t),
                );
              }
              return Column(
                children: _buildResponsiveItems(context, t),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildResponsiveItems(BuildContext context, dynamic t) {
    return [
      _buildInfoItem(
        context,
        icon: LucideIcons.link,
        label: t.ipLablel,
        value: widget.serverInfo.ip,
        copyText: widget.serverInfo.ip,
        copyMessage: t.copyIpMessage,
      ),
      _buildInfoItem(
        context,
        icon: LucideIcons.plug,
        label: t.portLabel,
        value: widget.serverInfo.port.toString(),
        copyText: widget.serverInfo.port.toString(),
        copyMessage: t.portMessage,
      ),
      _buildInfoItem(
        context,
        icon: LucideIcons.monitor,
        label: t.osLable,
        value: widget.serverInfo.os,
        customIcon: OSLogo(os: widget.serverInfo.os),
      ),
      _buildInfoItem(
        context,
        icon: LucideIcons.cpu,
        label: "Version",
        value: widget.serverInfo.version,
      ),
    ];
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    String? copyText,
    String? copyMessage,
  }) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.mutedForeground),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.small),
              Text(
                value,
                style: theme.textTheme.large.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (copyText != null)
          ShadButton.ghost(
            padding: EdgeInsets.zero,
            width: 32,
            height: 32,
            onPressed: () => copyToClipBoard(
              text: copyText,
              message: copyMessage ?? "Copied",
            ),
            child: const Icon(LucideIcons.copy, size: 14),
          ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    String? copyText,
    String? copyMessage,
    Widget? customIcon,
  }) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          customIcon ??
              Icon(icon, size: 16, color: theme.colorScheme.mutedForeground),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.textTheme.small,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: theme.textTheme.p.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (copyText != null) ...[
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => copyToClipBoard(
                          text: copyText,
                          message: copyMessage ?? "Copied",
                        ),
                        child: Icon(LucideIcons.copy,
                            size: 12, color: theme.colorScheme.primary),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
