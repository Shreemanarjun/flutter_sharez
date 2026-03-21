import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/file_download_pod.dart';

final downloadsQueuePod =
    NotifierProvider<DownloadsQueueNotifier, List<FilePath>>(
        DownloadsQueueNotifier.new);

class DownloadsQueueNotifier extends Notifier<List<FilePath>> {
  @override
  List<FilePath> build() {
    return [];
  }

  void downloadAll(List<FilePath> files) {
    state = files;
    for (final file in files) {
      ref.read(fileDownloaderPod(file).notifier).startDownload();
    }
  }

  void clearQueue() {
    state = [];
  }
}
