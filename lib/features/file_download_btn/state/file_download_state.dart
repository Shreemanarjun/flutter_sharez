import 'dart:convert';

class DownloadState {
  final Progress progress;
  final bool isPaused;
  final bool isCompleted;
  final bool isError;

  const DownloadState({
    required this.progress,
    required this.isPaused,
    required this.isCompleted,
    required this.isError,
  });

  factory DownloadState.initial() => DownloadState(
        progress: Progress(currentProgress: 0, speed: 0, remainTime: 0),
        isPaused: false,
        isCompleted: false,
        isError: false,
      );

  factory DownloadState.downloading() => DownloadState(
      progress: Progress(currentProgress: 0, speed: 0, remainTime: 0),
      isPaused: false,
      isCompleted: false,
      isError: false);

  factory DownloadState.completed() => DownloadState(
      progress: Progress(currentProgress: 0, speed: 0, remainTime: 0),
      isPaused: false,
      isCompleted: true,
      isError: false);

  factory DownloadState.error() => DownloadState(
      progress: Progress(currentProgress: 0, speed: 0, remainTime: 0),
      isPaused: false,
      isCompleted: false,
      isError: true);

  DownloadState copyWith({
    Progress? progress,
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
      'progress': progress.toMap(),
      'isPaused': isPaused,
      'isCompleted': isCompleted,
      'isError': isError,
    };
  }

  factory DownloadState.fromMap(Map<String, dynamic> map) {
    return DownloadState(
      progress: Progress.fromMap(map['progress']),
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

class Progress {
  double currentProgress;
  double speed;
  double remainTime;
  Progress({
    required this.currentProgress,
    required this.speed,
    required this.remainTime,
  });

  Progress copyWith({
    double? currentProgress,
    double? speed,
    double? remainTime,
  }) {
    return Progress(
      currentProgress: currentProgress ?? this.currentProgress,
      speed: speed ?? this.speed,
      remainTime: remainTime ?? this.remainTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentProgress': currentProgress,
      'speed': speed,
      'remainTime': remainTime,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      currentProgress: map['currentProgress']?.toDouble() ?? 0.0,
      speed: map['speed']?.toDouble() ?? 0.0,
      remainTime: map['remainTime']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source));

  @override
  String toString() =>
      'Progress(currentProgress: $currentProgress, speed: $speed, remainTime: $remainTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Progress &&
        other.currentProgress == currentProgress &&
        other.speed == speed &&
        other.remainTime == remainTime;
  }

  @override
  int get hashCode =>
      currentProgress.hashCode ^ speed.hashCode ^ remainTime.hashCode;
}
