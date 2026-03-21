import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/download_item.dart';

final downloadHistoryPod =
    NotifierProvider<DownloadHistoryNotifier, List<DownloadItem>>(
        DownloadHistoryNotifier.new);

class DownloadHistoryNotifier extends Notifier<List<DownloadItem>> {
  static const _key = 'download_history';

  @override
  List<DownloadItem> build() {
    final storage = ref.read(appStorageProvider);
    final historyJson = storage.get(key: _key);
    if (historyJson != null) {
      try {
        final List decoded = jsonDecode(historyJson);
        return decoded.map((e) => DownloadItem.fromMap(e)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  void addDownload(DownloadItem item) {
    // Check if item already exists with same path, update it
    final index = state.indexWhere((e) => e.path == item.path);
    if (index != -1) {
      final newState = List<DownloadItem>.from(state);
      newState[index] = item;
      state = newState;
    } else {
      state = [item, ...state];
    }
    _save();
  }

  void _save() {
    final storage = ref.read(appStorageProvider);
    final encoded = jsonEncode(state.map((e) => e.toMap()).toList());
    storage.put(key: _key, value: encoded);
  }

  void clearHistory() {
    state = [];
    _save();
  }
}
