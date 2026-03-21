import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

final senderServicePod = Provider.autoDispose<SenderService>((ref) {
  final service = SenderService(
    port: ref.watch(defaultPortProvider),
    ref: ref,
  );
  ref.onDispose(() => service.stopServer());
  return service;
}, name: 'senderServicePod');

final defaultPortProvider =
    NotifierProvider<DefaultPortNotifier, int>(() => DefaultPortNotifier());

class DefaultPortNotifier extends Notifier<int> {
  @override
  int build() => 4242;

  void setPort(int port) => state = port;
}

final paltformFilesPod = Provider.autoDispose<List<PlatformFile>>(
  (ref) {
    return ref.watch(
      selectedFilesPod.select(
        (value) => value.map((e) => e.file).toList(),
      ),
    );
  },
  name: 'paltformFilesPod',
);
