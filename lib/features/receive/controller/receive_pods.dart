import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:network_discovery/network_discovery.dart';

final checkServerPod =
    FutureProvider.autoDispose.family<SenderModel?, ({String ip, int port})>(
  (ref, record) async {
    try {
      final deviceAddress = 'http://${record.ip}:${record.port}';
      final result = await ref.watch(dioProvider(deviceAddress)).get("/server");

      if (result.statusCode == 200) {
        talker.debug("Scanned $record with result: $result");
        return SenderModel.fromMap(result.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  },
  name: 'checkServerPod',
);

class ReceiverServerListNotifier extends StreamNotifier<List<SenderModel>> {
  @override
  Stream<List<SenderModel>> build() async* {
    final controller = StreamController<List<SenderModel>>();
    final scannedOkdevices = <SenderModel>[];
    final currentaddress = await NetworkDiscovery.discoverDeviceIpAddress();
    final currentsubnet =
        currentaddress.substring(0, currentaddress.lastIndexOf('.'));
    const List<int> ports = [80, 443, 445, 8080];

    talker.info("current subnet $currentsubnet");

    final storage = ref.read(appStorageProvider);
    final myUUID = storage.get(key: 'device_uuid');

    // mDNS Discovery
    BonsoirDiscovery discovery = BonsoirDiscovery(type: '_sharez._tcp');
    await discovery.initialize();

    final mdnsSubscription = discovery.eventStream!.listen((event) async {
      if (event is BonsoirDiscoveryServiceFoundEvent) {
        event.service.resolve(discovery.serviceResolver);
      } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
        final service = event.service;
        final ip = service.attributes['ip'] ?? service.name;
        final isOKServer = await ref
            .watch(checkServerPod((ip: ip, port: service.port)).future);
        if (isOKServer != null &&
            isOKServer.deviceUUID != myUUID &&
            !scannedOkdevices.any((d) => d.deviceUUID == isOKServer.deviceUUID)) {
          scannedOkdevices.add(isOKServer);
          controller.add(List.from(scannedOkdevices));
        }
      }
    });

    await discovery.start();

    final subnetSubscription =
        NetworkDiscovery.discoverMultiplePorts(currentsubnet, ports).listen(
      (address) async {
        talker.info('address $address');
        if (address.ip != currentaddress) {
          final futures = address.openPorts.map((port) async {
            final isOKServer = await ref
                .read(checkServerPod((ip: address.ip, port: port)).future);
            if (isOKServer != null &&
                isOKServer.deviceUUID != myUUID &&
                !scannedOkdevices
                    .any((d) => d.deviceUUID == isOKServer.deviceUUID)) {
              scannedOkdevices.add(isOKServer);
              controller.add(List.from(scannedOkdevices));
            }
          });

          await Future.wait(futures);
        }
      },
      onDone: () {
        if (scannedOkdevices.isEmpty) {
          controller.add([]);
        }
      },
    );

    ref.onDispose(() {
      mdnsSubscription.cancel();
      subnetSubscription.cancel();
      discovery.stop();
      controller.close();
    });

    yield* controller.stream;
  }
}

final oKServersListProvider =
    StreamNotifierProvider<ReceiverServerListNotifier, List<SenderModel>>(
  ReceiverServerListNotifier.new,
  name: 'oKServersListProvider',
);
