import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/controller/shared_history_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';

class SendStateNotifier extends AsyncNotifier<SendState> {
  @override
  FutureOr<SendState> build() async {
    // We watch the service to keep it alive for the duration of this notifier
    ref.watch(senderServicePod);
    return await _startServerInternal();
  }

  Future<void> startServer() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _startServerInternal());
  }

  Future<SendState> _startServerInternal() async {
    SendState mystate = const StartingServer();

    // Use read as we already watch the provider in build()
    final sendService = ref.read(senderServicePod);
    final result = await sendService.startServer(
      onCheckServerCalled: (receivermodel) async {
        final Completer<bool> sendConfirmCompleter = Completer();
        if (sendConfirmCompleter.isCompleted) {
          return false;
        } else {
          final value = await ref
              .read(autorouterProvider)
              .navigate(ConfirmConnectionDialogRoute(
                receiverModel: receivermodel,
                onCofirmation: (v) {
                  if (!sendConfirmCompleter.isCompleted) {
                    sendConfirmCompleter.complete(v);
                    if (v == true) {
                      // Navigate to this consumer's files too for mutual sharing
                      ref.read(autorouterProvider).navigate(
                            DeviceShareRoute(
                              senderModel: SenderModel(
                                ip: receivermodel.ip,
                                port: receivermodel.port,
                                filesCount: 0, // Will be updated by pod
                                host: receivermodel.host,
                                deviceName: receivermodel.host,
                                deviceUUID: receivermodel.deviceUUID,
                                os: receivermodel.os,
                                version: receivermodel.version,
                              ),
                            ),
                          );
                    }
                  }
                },
              ));
          if (value is bool) {
            return value;
          }
          return await sendConfirmCompleter.future;
        }
      },
    );
    result.when((success) {
      final files = ref.read(paltformFilesPod);
      ref.read(sharedHistoryPod.notifier).addSharedFiles(files);
      mystate = StartedServer(serverInfo: sendService.getServerInfo());
    }, (error) {
      mystate = ServerError(
        error:
            "Server cannot be started due to ${error.message}. Please make sure you have connected to wifi",
      );
    });
    return mystate;
  }

  Future<void> stopServer() async {
    state = const AsyncLoading();
    await ref.read(senderServicePod).stopServer();
    state = const AsyncData(StoppedServer());
  }

  Future<void> pushTo(ReceiverModel receiver) async {
    final sender = state.value;
    if (sender is! StartedServer) return;

    final ips = await getAllIPs();
    final myIp = ips.when((success) => success.first, (error) => '');

    final senderModel = SenderModel(
      ip: myIp,
      port: sender.serverInfo.port,
      filesCount: ref.read(selectedFilesPod).length,
      host: sender.serverInfo.host,
      deviceName: sender.serverInfo.deviceName,
      deviceUUID: sender.serverInfo.deviceUUID,
      os: sender.serverInfo.os,
      version: sender.serverInfo.version,
    );

    try {
      final dio = ref.read(dioProvider('http://${receiver.ip}:${receiver.port}'));
      await dio.post('/push', data: senderModel.toMap());
    } catch (e) {
      // Handle error
    }
  }
}
