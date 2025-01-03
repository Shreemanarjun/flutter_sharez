import 'package:dart_mappable/dart_mappable.dart';
part 'file_download_state.mapper.dart';

@MappableClass()
sealed class DownloadState with DownloadStateMappable {
  const DownloadState(); // Factory constructor for initial state
  factory DownloadState.initial() => const InitialDownloadState();

  // Factory constructor for downloading state
  factory DownloadState.downloading({
    required Progress progress,
    required bool isPaused,
  }) =>
      DownloadingState(
        progress: progress,
        isPaused: isPaused,
      );

  // Factory constructor for completed state
  factory DownloadState.completed() => const CompletedDownloadState();

  // Factory constructor for error state
  factory DownloadState.error() => const ErrorDownloadState();

  // Factory constructor for merge done state
  factory DownloadState.mergeDone({required bool isCompleted}) =>
      MergeDoneState(isCompleted);
}

@MappableClass()
class InitialDownloadState extends DownloadState
    with InitialDownloadStateMappable {
  const InitialDownloadState();
}

@MappableClass()
class DownloadingState extends DownloadState with DownloadingStateMappable {
  final Progress progress;
  final bool isPaused;

  const DownloadingState({required this.progress, required this.isPaused});
}

@MappableClass()
class CompletedDownloadState extends DownloadState
    with CompletedDownloadStateMappable {
  const CompletedDownloadState();
}

@MappableClass()
class ErrorDownloadState extends DownloadState with ErrorDownloadStateMappable {
  const ErrorDownloadState();
}

@MappableClass()
class MergeDoneState extends DownloadState with MergeDoneStateMappable {
  final bool isCompleted;
  const MergeDoneState(this.isCompleted);
}

@MappableClass()
class Progress with ProgressMappable {
  double currentProgress;
  double speed;
  double remainTime;

  Progress({
    required this.currentProgress,
    required this.speed,
    required this.remainTime,
  });
}
