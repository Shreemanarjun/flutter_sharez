import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender_service_pod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';

class SendStateNotifier extends AutoDisposeAsyncNotifier<SendState> {
  @override
  FutureOr<SendState> build() async {
    await startServer();
    return future;
  }

  Future<void> startServer() async {
    final files = ref.watch(selectedFilesPod);
    if (files.isNotEmpty) {
      state = const AsyncValue.data(StartingServer());
      final result = await ref.watch(senderServicePod).startServer(
        onCheckServerCalled: (receivermodel) async {
          return false;
          // final value = await showConfirmationDialog(receivermodel);
          // if (value == true) {
          //   Logger.log('Sender accepted');
          // } else {
          //   Logger.log('Sender Rejected');
          // }
          // return value;
        },
      );
      result.when((success) {
        state = AsyncValue.data(StartedServer(
            serverInfo: ref.watch(senderServicePod).getServerInfo()));
      }, (error) {
        state = AsyncValue.data(ServerError(
          error: "Server cannot be started due to ${error.message}",
        ));
      });
    } else {
      ref.read(selectedFilesPod.notifier).resetState();
      state = AsyncValue.data(ServerError(error: 'No files Selected Yet'));
    }
  }
}
