import 'dart:math';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/receive/view/widget/connect_btn.dart';

import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

@RoutePage(
  deferredLoading: true,
)
class ReceiveStatePage extends ConsumerWidget {
  const ReceiveStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return Scaffold(
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: t.manuallyAdd,
            onTap: () {
              context.navigateTo(const ManualConnectRoute());
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: t.qrScan,
            onTap: () {
              context.navigateTo(const QrScanRoute());
            },
          ),
        ],
        useRotationAnimation: true,
        child: Transform.rotate(
          angle: pi,
          child: const Icon(Icons.expand_circle_down),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final t = ref.watch(translationsPod);
          final okserversAsync = ref.watch(oKServersListProvider);
          return okserversAsync.easyWhen(
            data: (sendermodels) {
              if (sendermodels.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.noDevicesinNetwork,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FilledButton.icon(
                          onPressed: () {
                            ref.invalidate(oKServersListProvider);
                          },
                          icon: const Icon(Icons.refresh_sharp),
                          label: Text(t.rescan),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          t.foundDevices(n: sendermodels.length),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator.adaptive(
                          onRefresh: () =>
                              ref.refresh(oKServersListProvider.future),
                          child: ListView.builder(
                            itemCount: sendermodels.length,
                            itemBuilder: (context, index) {
                              final sendermodel = sendermodels[index];
                              return ListTile(
                                leading: OSLogo(os: sendermodel.os),
                                title: Text("${sendermodel.version}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.receiveShareFiles(
                                        n: sendermodel.filesCount ?? 0,
                                      ),
                                    ),
                                    Text(
                                      "${sendermodel.ip}:${sendermodel.port}",
                                    ),
                                  ],
                                ),
                                trailing: ConnectBtn(
                                  senderModel: sendermodel,
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
            },
            loadingWidget: () {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RepaintBoundary(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        t.scanningNetwork,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: false,
          );
        },
      ),
    );
  }
}
