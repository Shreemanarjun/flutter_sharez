import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

class TransferInfo {
  final String fileName;
  final int totalSize;
  final int sentBytes;
  final double speed; // Bytes per second
  final DateTime lastUpdate;

  TransferInfo({
    required this.fileName,
    required this.totalSize,
    required this.sentBytes,
    required this.speed,
    required this.lastUpdate,
  });

  double get progress => totalSize > 0 ? sentBytes / totalSize : 0;

  TransferInfo copyWith({
    String? fileName,
    int? totalSize,
    int? sentBytes,
    double? speed,
    DateTime? lastUpdate,
  }) {
    return TransferInfo(
      fileName: fileName ?? this.fileName,
      totalSize: totalSize ?? this.totalSize,
      sentBytes: sentBytes ?? this.sentBytes,
      speed: speed ?? this.speed,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

final uploadProgressPod =
    NotifierProvider<UploadProgressNotifier, Map<String, TransferInfo>>(
        UploadProgressNotifier.new);

class UploadProgressNotifier extends Notifier<Map<String, TransferInfo>> {
  @override
  Map<String, TransferInfo> build() {
    ref.listen(selectedFilesPod, (previous, next) {
      final nextNames = next.map((e) => e.file.name).toSet();
      final currentUploads = state.keys.toSet();

      final toRemove = currentUploads.difference(nextNames);
      if (toRemove.isNotEmpty) {
        state = {
          for (final entry in state.entries)
            if (!toRemove.contains(entry.key)) entry.key: entry.value
        };
      }
    });
    return {};
  }

  void updateProgress(String fileName, int totalSize, int additionalBytes) {
    final now = DateTime.now();
    final current = state[fileName];

    if (current == null) {
      state = {
        ...state,
        fileName: TransferInfo(
          fileName: fileName,
          totalSize: totalSize,
          sentBytes: additionalBytes,
          speed: 0,
          lastUpdate: now,
        ),
      };
    } else {
      final elapsed =
          now.difference(current.lastUpdate).inMilliseconds / 1000.0;
      double newSpeed = current.speed;
      if (elapsed > 0) {
        // Simple smoothing
        final instantSpeed = additionalBytes / elapsed;
        newSpeed = (current.speed * 0.8) + (instantSpeed * 0.2);
      }

      state = {
        ...state,
        fileName: current.copyWith(
          sentBytes: current.sentBytes + additionalBytes,
          speed: newSpeed,
          lastUpdate: now,
        ),
      };
    }
  }

  void removeTransfer(String fileName) {
    final newState = Map<String, TransferInfo>.from(state);
    newState.remove(fileName);
    state = newState;
  }
}
