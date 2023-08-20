import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cache_extensions.dart';
import 'package:network_discovery/network_discovery.dart';
import 'package:velocity_x/velocity_x.dart';

final networkAddressListStreamProvider =
    StreamProvider.autoDispose<List<NetworkAddress>>(
  (ref) async* {
    final controller = StreamController<List<NetworkAddress>>();
    final currentaddress = await NetworkDiscovery.discoverDeviceIpAddress();
    final currentsubnet =
        currentaddress.substring(0, currentaddress.lastIndexOf('.'));
    const List<int> ports = [80, 443, 445, 8080];
    final List<NetworkAddress> currentList = [];
    talker.info("current subnet $currentsubnet");
    final subscription =
        NetworkDiscovery.discoverMultiplePorts(currentsubnet, ports).listen(
      (address) async {
        talker.info('address $address');
        if (address.ip != currentaddress) {
          final newList = {...currentList, address}.toList();
          controller.add(newList);
        } else {
          controller.add([]);
        }
      },
      onError: (error) {
        // Handle errors if needed
      },
      onDone: () {
        controller.close();
      },
    );
    ref.onCancel(() async {
      controller.close();
      await subscription.cancel();
    });
    ref.onDispose(() async {
      controller.close();
      await subscription.cancel();
    });

    yield* controller.stream;
  },
  name: 'networkAddressListStreamProvider',
);

final checkServerPod = FutureProvider.autoDispose
    .family<SenderModel?, ({NetworkAddress address, int port})>(
  (ref, record) async {
    talker.info(record.toString());
    try {
      final result = await ref
          .watch(dioProvider('http://${record.address.ip}:${record.port}'))
          .get("/server");

      if (result.statusCode == 200) {
        return SenderModel.fromMap(result.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  },
  name: 'checkServerPod',
);

final oKServersListProvider = FutureProvider.autoDispose<List<SenderModel>>(
  (ref) async {
    final addresses = await ref.watch(networkAddressListStreamProvider.future);
    ref.autoRefresh(duration: 10.seconds);
    final okaddresses = <SenderModel>[];
    for (var address in addresses) {
      for (var port in address.openPorts) {
        final isOKServer = await ref
            .watch(checkServerPod((address: address, port: port)).future);
        if (isOKServer != null) {
          okaddresses.add(isOKServer);
        }
      }
    }
    return okaddresses;
  },
  name: 'oKServersListProvider',
);
