import 'dart:convert';
import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

final pushReceiverProvider = Provider<PushReceiverService>((ref) {
  final service = PushReceiverService(ref);
  service.start();
  return service;
});

class PushReceiverService {
  final Ref _ref;
  HttpServer? _server;
  BonsoirBroadcast? _broadcast;

  int? get port => _server?.port;

  PushReceiverService(this._ref);

  Future<void> start() async {
    final router = shelf_router.Router();

    router.post('/push', (Request request) async {
      final payload = jsonDecode(await request.readAsString());
      final senderModel = SenderModel.fromMap(payload);

      final receiverModel = ReceiverModel(
        ip: senderModel.ip,
        port: senderModel.port,
        host: senderModel.host,
        os: senderModel.os,
        version: senderModel.version,
        deviceUUID: senderModel.deviceUUID,
      );

      talker.info("Received Push Request from ${senderModel.deviceName}");

      // Show confirmation dialog on the UI
      _ref.read(autorouterProvider).navigate(
            ConfirmConnectionDialogRoute(
              receiverModel: receiverModel,
              isConfirmingReceiver: false,
              onCofirmation: (accepted) {
                if (accepted) {
                  _ref.read(autorouterProvider).navigate(
                        DeviceShareRoute(senderModel: senderModel),
                      );
                }
              },
            ),
          );

      return Response.ok(jsonEncode({'status': 'accepted'}));
    });

    try {
      final ipResult = await getAllIPs();
      final iplist = ipResult.when((success) => success, (error) => <String>[]);
      if (iplist.isEmpty) return;

      final ip = iplist.first;
      final storage = _ref.read(appStorageProvider);
      final uuid = storage.get(key: 'device_uuid') ?? '';

      _server = await io.serve(router.call, InternetAddress.anyIPv4, 0);
      final port = _server!.port;

      talker.info("Push Receiver started on $ip:$port");

      _broadcast = BonsoirBroadcast(
        service: BonsoirService(
          name: "Sharez-Receiver-${ip.replaceAll('.', '-')}",
          type: '_sharezpush._tcp',
          port: port,
          attributes: {
            'ip': ip,
            'type': 'receiver',
            'uuid': uuid,
            'os': Platform.operatingSystem,
            'version': Platform.operatingSystemVersion,
          },
        ),
      );
      await _broadcast!.initialize();
      await _broadcast!.start();
    } catch (e) {
      talker.error("Failed to start Push Receiver: $e");
    }
  }

  void stop() {
    _server?.close();
    _broadcast?.stop();
  }
}
