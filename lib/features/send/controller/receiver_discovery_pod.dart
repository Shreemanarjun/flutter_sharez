import 'dart:async';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';

/// Provider for list of discovered receivers on the local network.
final receiverDiscoveryProvider =
    StreamNotifierProvider<ReceiverDiscoveryNotifier, List<ReceiverModel>>(
        ReceiverDiscoveryNotifier.new);

/// [ReceiverDiscoveryNotifier] manages the discovery of other devices 
/// that have the [PushReceiverService] started.
/// 
/// It listens for mDNS services of type `_sharezpush._tcp`.
class ReceiverDiscoveryNotifier extends StreamNotifier<List<ReceiverModel>> {
  @override
  Stream<List<ReceiverModel>> build() async* {
    final controller = StreamController<List<ReceiverModel>>();
    final foundReceivers = <ReceiverModel>[];
    
    final storage = ref.read(appStorageProvider);
    final uuid = storage.get(key: 'device_uuid') ?? '';

    talker.info("Starting Receiver Discovery...");

    // Matches the service type used by [PushReceiverService]
    BonsoirDiscovery discovery = BonsoirDiscovery(type: '_sharezpush._tcp');
    await discovery.initialize();

    final subscription = discovery.eventStream!.listen((event) {
      if (event is BonsoirDiscoveryServiceFoundEvent) {
        // Resolve the found service to get its IP and attributes.
        event.service.resolve(discovery.serviceResolver);
      } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
        final service = event.service;
        final ip = service.attributes['ip'] ?? service.name;
        
        // Populate receiver model from mDNS service attributes.
        final receiver = ReceiverModel(
          ip: ip,
          port: service.port,
          host: service.name,
          os: service.attributes['os'] ?? 'Unknown',
          version: service.attributes['version'] ?? '1.0.0',
          deviceUUID: service.attributes['uuid'] ?? '',
        );

        // Don't show ourselves in the discovered list
        if (receiver.deviceUUID != uuid &&
            !foundReceivers.any((r) => r.deviceUUID == receiver.deviceUUID)) {
          foundReceivers.add(receiver);
          controller.add(List.from(foundReceivers));
        }
      }
    });

    await discovery.start();

    // Cleanup resources when the provider is no longer watched.
    ref.onDispose(() {
      subscription.cancel();
      discovery.stop();
      if (!controller.isClosed) {
        controller.close();
      }
    });

    yield* controller.stream;
  }
}
