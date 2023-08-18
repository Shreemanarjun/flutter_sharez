import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/qr_scan/qr_scan_page.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/receive/view/widget/connect_btn.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
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
        overlayColor: Colors.transparent,
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
                  return const AlertDialog(
                    content: QrScanPage(),
                  );
                },
              );
            },
          ),
        ],
        useRotationAnimation: true,
        child: const Icon(Icons.expand_circle_down).rotate180(),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final okserversAsync = ref.watch(oKServersListProvider);
          return okserversAsync.easyWhen(
            data: (sendermodels) {
              if (sendermodels.isEmpty) {
                return [
                  "No devices in the network!".text.bold.xl.makeCentered(),
                  FilledButton.icon(
                    onPressed: () {
                      ref.invalidate(networkAddressListStreamProvider);
                    },
                    icon: const Icon(Icons.refresh_sharp),
                    label: "Rescan".text.make(),
                  ).p12()
                ].vStack(
                  alignment: MainAxisAlignment.center,
                  crossAlignment: CrossAxisAlignment.center,
                );
              } else {
                return <Widget>[
                  "Found ${sendermodels.length} devices"
                      .text
                      .xl
                      .bold
                      .makeCentered(),
                  RefreshIndicator.adaptive(
                      onRefresh: () =>
                          ref.refresh(networkAddressListStreamProvider.future),
                      child: ListView.builder(
                        itemCount: sendermodels.length,
                        itemBuilder: (context, index) {
                          final sendermodel = sendermodels[index];
                          return ListTile(
                              leading: OSLogo(os: sendermodel.os),
                              title: "${sendermodel.version}".text.make(),
                              subtitle: <Widget>[
                                "Sharing ${sendermodel.filesCount} files"
                                    .text
                                    .make(),
                                "${sendermodel.ip}:${sendermodel.port}"
                                    .text
                                    .make(),
                              ].vStack(
                                crossAlignment: CrossAxisAlignment.start,
                              ),
                              trailing: const ConnectBtn());
                        },
                      )).expand(),
                ].vStack().p8();
              }
            },
          );
        },
      ),
    );
  }
}
