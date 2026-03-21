import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage(
  deferredLoading: true,
)
class QrScanPage extends ConsumerStatefulWidget {
  const QrScanPage({super.key});

  @override
  ConsumerState<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends ConsumerState<QrScanPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ShadCard(
          title: const Text('QR Scanner'),
          description: const Text(
            'QR code scanning is currently disabled to ensure maximum compatibility across platforms. You can manually enter an IP address instead.',
            textAlign: TextAlign.center,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ShadButton(
              child: const Text('Close'),
              onPressed: () {
                context.router.maybePop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
