import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';

class SendStateNotifier extends AutoDisposeAsyncNotifier<SendState> {
  @override
  FutureOr<SendState> build() async {
    return await startServer();
  }

  Future<SendState> startServer() async {
    SendState mystate = const StartingServer();

    final files = ref.read(selectedFilesPod);
    final sendService = ref.watch(senderServicePod);
    if (files.isNotEmpty) {
      final result = await sendService.startServer(
        onCheckServerCalled: (receivermodel) async {
          final Completer<bool> sendConfirmCompleter = Completer();
          if (sendConfirmCompleter.isCompleted) {
            return false;
          } else {
            ref.read(autorouterProvider).navigate(ConfirmConnectionDialogRoute(
                  receiverModel: receivermodel,
                  onCofirmation: (v) {
                    if (!sendConfirmCompleter.isCompleted) {
                      sendConfirmCompleter.complete(v);
                    }
                  },
                ));
            return await sendConfirmCompleter.future;
          }
        },
      );
      result.when((success) {
        mystate = StartedServer(serverInfo: sendService.getServerInfo());
      }, (error) {
        mystate = ServerError(
          error:
              "Server cannot be started due to ${error.message}. Please make sure you have connected to wifi",
        );
      });
    } else {
      ref.read(selectedFilesPod.notifier).resetState();
      mystate = ServerError(error: 'No files Selected Yet');
    }
    return mystate;
  }
}
