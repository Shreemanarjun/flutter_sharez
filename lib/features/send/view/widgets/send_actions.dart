import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SendActions extends ConsumerStatefulWidget {
  final ServerInfo serverInfo;
  const SendActions({
    super.key,
    required this.serverInfo,
  });

  @override
  ConsumerState<SendActions> createState() => _SendActionsState();
}

class _SendActionsState extends ConsumerState<SendActions> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);
    final fullAddress =
        'http://${widget.serverInfo.ip}:${widget.serverInfo.port}';

    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Server Management",
            style: theme.textTheme.small.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ShadTooltip(
                  builder: (context) => Text(t.copyAddressTooltip),
                  child: ShadButton.outline(
                    width: double.infinity,
                    onPressed: () async => await copyToClipBoard(
                      text: fullAddress,
                      message: t.addressCopiedMsg,
                    ),
                    trailing: Text(t.copyAddressTooltip),
                    child: const Icon(LucideIcons.copy, size: 16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ShadTooltip(
                builder: (context) => Text(t.stopSharing),
                child: ShadButton.destructive(
                  onPressed: () async {
                    await ref.read(autorouterProvider).navigate(
                          StopServerActionDialogRoute(
                            onYesClicked: () {},
                          ),
                        );
                  },
                  child: const Icon(LucideIcons.circleStop, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
