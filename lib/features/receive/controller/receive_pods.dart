import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:network_discovery/network_discovery.dart';

final checkServerPod = FutureProvider.autoDispose
    .family<SenderModel?, ({NetworkAddress address, int port})>(
  (ref, record) async {
    try {
      final deviceAdderss = 'http://${record.address.ip}:${record.port}';
      final result = await ref.watch(dioProvider(deviceAdderss)).get("/server");

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
    final subscription =
        NetworkDiscovery.discoverMultiplePorts(currentsubnet, ports).listen(
      (address) async {
        talker.info('address $address');
        if (address.ip != currentaddress) {
          for (var port in address.openPorts) {
            final isOKServer = await ref
                .watch(checkServerPod((address: address, port: port)).future);
            if (isOKServer != null) {
              scannedOkdevices.add(isOKServer);
              state = AsyncData(scannedOkdevices);
            }
          }
        }
      },
      onError: (error) {
        // Handle errors if needed
      },
      onDone: () {
        controller.close();
      },
    );
    ref.onCancel(
      () {
        subscription.cancel();
      },
    );
    ref.onDispose(
      () {
        subscription.cancel();
      },
    );

    yield* controller.stream;
  }
}

final oKServersListProvider =
    StreamNotifierProvider<ReceiverServerListNotifier, List<SenderModel>>(
  ReceiverServerListNotifier.new,
  name: 'oKServersListProvider',
);
