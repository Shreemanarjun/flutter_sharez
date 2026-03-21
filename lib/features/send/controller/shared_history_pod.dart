import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/shared_item.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

final sharedHistoryPod =
    NotifierProvider<SharedHistoryNotifier, List<SharedItem>>(
        SharedHistoryNotifier.new);

class SharedHistoryNotifier extends Notifier<List<SharedItem>> {
  static const _key = 'shared_history';

  @override
  List<SharedItem> build() {
    final storage = ref.read(appStorageProvider);
    final historyJson = storage.get(key: _key);
    if (historyJson != null) {
      try {
        final List decoded = jsonDecode(historyJson);
        return decoded.map((e) => SharedItem.fromMap(e)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  void addSharedFiles(List<PlatformFile> files) {
    final List<SharedItem> current = List.from(state);
    for (final file in files) {
      if (file.path == null) continue;
      // Remove old entry with same path
      current.removeWhere((e) => e.path == file.path);
      current.insert(
        0,
        SharedItem(
          name: file.name,
          size: file.size,
          path: file.path!,
          shareDate: DateTime.now(),
        ),
      );
    }
    // Keep only last 50 items
    state = current.take(50).toList();
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

  void reshare(SharedItem item) {
    final platformFile = PlatformFile(
      path: item.path,
      name: item.name,
      size: item.size,
    );
    ref.read(selectedFilesPod.notifier).addFile(platformFile);
  }
}
