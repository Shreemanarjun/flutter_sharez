import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:platform_info/platform_info.dart';
import 'package:velocity_x/velocity_x.dart';

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
          ? <Widget>[
              t.qrscannotSupported.text.isIntrinsic.make(),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: t.ok.text.isIntrinsic.make(),
              ).p8()
            ].vStack(
              axisSize: MainAxisSize.min,
            )
          : AiBarcodeScanner(
              onDetect: (value) {
                talker.debug(value);
                scannerController.stop();
                Navigator.of(context).pop();
              },
              controller: scannerController,
            ).hHalf(context),
    );
  }
}
