import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:platform_info/platform_info.dart';

@RoutePage(
  deferredLoading: true,
)
class QrScanPage extends ConsumerStatefulWidget {
  const QrScanPage({super.key});

  @override
  ConsumerState<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends ConsumerState<QrScanPage> {
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    return AlertDialog(
      content: Platform.I.desktop
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(t.qrscannotSupported),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(t.ok),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: AiBarcodeScanner(
                onDetect: (value) {
                  talker.debug(value);
                  scannerController.stop();
                  Navigator.of(context).pop();
                },
                controller: scannerController,
              ),
            ),
    );
  }
}
