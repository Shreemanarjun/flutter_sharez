import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/receive/view/widget/connect_btn.dart';
import 'package:flutter_sharez/generated/l10n.g.dart';

import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ReceiveStatePage extends StatelessWidget {
  const ReceiveStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: LocaleKeys.manuallyAdd.tr(),
            onTap: () {
              context.navigateTo(const ManualConnectRoute());
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: LocaleKeys.qrScan.tr(),
            onTap: () {
              context.navigateTo(const QrScanRoute());
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
                  LocaleKeys.noDevicesinNetwork
                      .tr()
                      .text
                      .bold
                      .xl
                      .makeCentered(),
                  FilledButton.icon(
                    onPressed: () {
                      ref.invalidate(networkAddressListStreamProvider);
                    },
                    icon: const Icon(Icons.refresh_sharp),
                    label: LocaleKeys.rescan.tr().text.make(),
                  ).p12()
                ].vStack(
                  alignment: MainAxisAlignment.center,
                  crossAlignment: CrossAxisAlignment.center,
                );
              } else {
                return <Widget>[
                  "LocaleKeys.foundDevices(sendermodels.length)"
                      .tr()
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
                                """     LocaleKeys.receiveShareFiles(
                                        sendermodel.filesCount ?? 0)"""
                                    .tr()
                                    .text
                                    .make(),
                                "${sendermodel.ip}:${sendermodel.port}"
                                    .text
                                    .make(),
                              ].vStack(
                                crossAlignment: CrossAxisAlignment.start,
                              ),
                              trailing: ConnectBtn(
                                senderModel: sendermodel,
                              ));
                        },
                      )).expand(),
                ].vStack().p8();
              }
            },
            loadingWidget: () {
              return <Widget>[
                const RepaintBoundary(
                    child: CircularProgressIndicator.adaptive()),
                LocaleKeys.scanningNetwork.tr().text.lg.make().p8(),
              ]
                  .vStack(
                    alignment: MainAxisAlignment.center,
                  )
                  .objectCenter();
            },
          );
        },
      ),
    );
  }
}
