import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/features/qr_scan/qr_scan_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ReceiveStatePage extends StatelessWidget {
  const ReceiveStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        children: [
          // SpeedDialChild(
          //   child: const Icon(Icons.radar),
          //   label: "Start Scan",
          // ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: "Manually Add",
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: "QR Scan",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return  Dialog(
                    child: const QrScanPage().h(600),
                  );
                },
              );
            },
          ),
        ],
        useRotationAnimation: true,
        child: const Icon(Icons.expand_circle_down).rotate180(),
      ),
    );
  }
}
