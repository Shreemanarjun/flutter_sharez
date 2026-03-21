import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';

class DeviceNameNotifier extends Notifier<String> {
  @override
  String build() {
    final storage = ref.watch(appStorageProvider);
    return storage.get(key: 'device_name') ?? '';
  }

  void set(String name) {
    ref.read(appStorageProvider).put(key: 'device_name', value: name);
    state = name;
  }
}

final deviceNameProvider = NotifierProvider<DeviceNameNotifier, String>(
  DeviceNameNotifier.new,
);

class AutoStartNotifier extends Notifier<bool> {
  @override
  bool build() {
    final storage = ref.watch(appStorageProvider);
    return storage.getBool(key: 'auto_start_server') ?? false;
  }

  void set(bool value) {
    ref.read(appStorageProvider).putBool(key: 'auto_start_server', value: value);
    state = value;
  }
}

final autoStartServerProvider = NotifierProvider<AutoStartNotifier, bool>(
  AutoStartNotifier.new,
);

class DownloadPathNotifier extends Notifier<String?> {
  @override
  String? build() {
    final storage = ref.watch(appStorageProvider);
    return storage.get(key: 'download_path');
  }

  void set(String? path) {
    if (path != null) {
      ref.read(appStorageProvider).put(key: 'download_path', value: path);
    }
    state = path;
  }
}

final downloadPathProvider =
    NotifierProvider<DownloadPathNotifier, String?>(DownloadPathNotifier.new);
