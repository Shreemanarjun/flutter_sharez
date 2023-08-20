import 'dart:convert';

class DownloadState {
  final double progress;
  final bool isPaused;
  final bool isCompleted;
  final bool isError;

  const DownloadState({
    required this.progress,
    required this.isPaused,
    required this.isCompleted,
    required this.isError,
  });

  factory DownloadState.initial() => const DownloadState(
      progress: 0, isPaused: false, isCompleted: false, isError: false);

  factory DownloadState.downloading() => const DownloadState(
      progress: 0, isPaused: false, isCompleted: false, isError: false);

  factory DownloadState.completed() => const DownloadState(
      progress: 100, isPaused: false, isCompleted: true, isError: false);

  factory DownloadState.error() => const DownloadState(
      progress: 0, isPaused: false, isCompleted: false, isError: true);

  DownloadState copyWith({
    double? progress,
    bool? isPaused,
    bool? isCompleted,
    bool? isError,
  }) {
    return DownloadState(
      progress: progress ?? this.progress,
      isPaused: isPaused ?? this.isPaused,
      isCompleted: isCompleted ?? this.isCompleted,
      isError: isError ?? this.isError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'progress': progress,
      'isPaused': isPaused,
      'isCompleted': isCompleted,
      'isError': isError,
    };
  }

  factory DownloadState.fromMap(Map<String, dynamic> map) {
    return DownloadState(
      progress: map['progress']?.toDouble() ?? 0.0,
      isPaused: map['isPaused'] ?? false,
      isCompleted: map['isCompleted'] ?? false,
      isError: map['isError'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadState.fromJson(String source) =>
      DownloadState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DownloadState(progress: $progress, isPaused: $isPaused, isCompleted: $isCompleted, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadState &&
        other.progress == progress &&
        other.isPaused == isPaused &&
        other.isCompleted == isCompleted &&
        other.isError == isError;
  }

  @override
  int get hashCode {
    return progress.hashCode ^
        isPaused.hashCode ^
        isCompleted.hashCode ^
        isError.hashCode;
  }
}
