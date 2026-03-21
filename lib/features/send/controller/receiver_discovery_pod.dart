import 'dart:async';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';

final receiverDiscoveryProvider =
    StreamNotifierProvider<ReceiverDiscoveryNotifier, List<ReceiverModel>>(
        ReceiverDiscoveryNotifier.new);

class ReceiverDiscoveryNotifier extends StreamNotifier<List<ReceiverModel>> {
  @override
  Stream<List<ReceiverModel>> build() async* {
    final controller = StreamController<List<ReceiverModel>>();
    final foundReceivers = <ReceiverModel>[];
    
    final storage = ref.read(appStorageProvider);
      final uuid = storage.get(key: 'device_uuid') ?? '';

    talker.info("Starting Receiver Discovery...");

    BonsoirDiscovery discovery = BonsoirDiscovery(type: '_sharez_push._tcp');
    await discovery.initialize();

    final subscription = discovery.eventStream!.listen((event) {
      if (event is BonsoirDiscoveryServiceFoundEvent) {
        event.service.resolve(discovery.serviceResolver);
      } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
        final service = event.service;
        final ip = service.attributes['ip'] ?? service.name;
        
        // Basic ReceiverModel from mDNS
        final receiver = ReceiverModel(
          ip: ip,
          port: service.port,
          host: service.name,
          os: service.attributes['os'] ?? 'Unknown', // Assuming 'os' attribute might exist
          version: service.attributes['version'] ?? '1.0.0', // Assuming 'version' attribute might exist
          deviceUUID: service.attributes['uuid'] ?? '',
        );

        if (receiver.deviceUUID != uuid &&
            !foundReceivers.any((r) => r.deviceUUID == receiver.deviceUUID)) {
          foundReceivers.add(receiver);
          controller.add(List.from(foundReceivers));
        }
      }
    });

    await discovery.start();

    ref.onDispose(() {
      subscription.cancel();
      discovery.stop();
      controller.close();
    });

    yield* controller.stream;
  }
}
