import 'dart:async';
import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';

/// Provider for list of discovered receivers on the local network.
final receiverDiscoveryProvider =
    NotifierProvider<ReceiverDiscoveryNotifier, AsyncValue<List<ReceiverModel>>>(
        ReceiverDiscoveryNotifier.new);

/// [ReceiverDiscoveryNotifier] manages the discovery of other devices
/// that have the [PushReceiverService] started.
class ReceiverDiscoveryNotifier
    extends Notifier<AsyncValue<List<ReceiverModel>>> {
  final _foundReceivers = <ReceiverModel>[];
  BonsoirDiscovery? _discovery;
  StreamSubscription? _subscription;

  @override
  AsyncValue<List<ReceiverModel>> build() {
    // Keep alive to prevent disposal/reinit during typical usage
    final link = ref.keepAlive();

    // Critical: watch storage to maintain dependency link
    final storage = ref.watch(appStorageProvider);
    final uuid = storage.get(key: 'device_uuid') ?? '';

    ref.onDispose(() {
      _cleanup();
      link.close();
    });

    // Fire-and-forget initialization
    _startDiscovery(uuid);

    return const AsyncLoading();
  }

  Future<void> _startDiscovery(String uuid) async {
    talker.info("Starting Receiver Discovery (Notifier Version)...");

    try {
      _cleanup();
      _discovery = BonsoirDiscovery(type: '_sharezpush._tcp');
      await _discovery!.initialize();

      _subscription = _discovery!.eventStream!.listen(
        (event) {
          if (event is BonsoirDiscoveryServiceFoundEvent) {
            event.service.resolve(_discovery!.serviceResolver);
          } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
            final service = event.service;
            final ip = service.attributes['ip'] ?? service.name;
            final receiver = ReceiverModel(
              ip: ip,
              port: service.port,
              host: service.name,
              os: service.attributes['os'] ?? 'Unknown',
              version: service.attributes['version'] ?? '1.0.0',
              deviceUUID: service.attributes['uuid'] ?? '',
            );

            if (receiver.deviceUUID != uuid &&
                !_foundReceivers
                    .any((r) => r.deviceUUID == receiver.deviceUUID)) {
              _foundReceivers.add(receiver);
              state = AsyncData(List.from(_foundReceivers));
            }
          }
        },
        onError: (e, st) {
          talker.error("mDNS Discovery Stream error: $e", e, st);
          state = AsyncError(e, st);
          _cleanup();
        },
      );

      await _discovery!.start();
    } catch (e, st) {
      talker.error("Failed to start Receiver Discovery: $e", e, st);
      state = AsyncError(e, st);
      _cleanup();
    }
  }

  void _cleanup() {
    _subscription?.cancel();
    _discovery?.stop();
    _subscription = null;
    _discovery = null;
  }

  /// Manually restart the discovery process.
  void restart() {
    _foundReceivers.clear();
    ref.invalidateSelf();
  }
}
