import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

@RoutePage(
  deferredLoading: true,
)
class QrScanPage extends StatelessWidget {
  const QrScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReaderWidget(
      showGallery: false,
      showToggleCamera: false,
      actionButtonsAlignment: Alignment.topRight,
      isMultiScan: false,
      onScan: (result) async {
        // Do something with the result
        talker.debug(result.text);
      },
    );
  }
}
