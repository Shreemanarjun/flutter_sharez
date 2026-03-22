import 'package:duration/duration.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/file_download_pod.dart';
import 'package:flutter_sharez/features/file_download_btn/state/file_download_state.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FileDownloadBtn extends ConsumerStatefulWidget {
  final FilePath filepath;
  const FileDownloadBtn({super.key, required this.filepath});

  @override
  ConsumerState<FileDownloadBtn> createState() => _FileDownloadBtnState();
}

class _FileDownloadBtnState extends ConsumerState<FileDownloadBtn> {
  @override
  Widget build(BuildContext context) {
    final downloadstateAsync = ref.watch(fileDownloaderPod(widget.filepath));
    return downloadstateAsync.easyWhen(
      data: (downloadState) {
        return switch (downloadState) {
          InitialDownloadState() => ShadButton.outline(
              onPressed: () async {
                HapticFeedback.lightImpact();
                await ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .startDownload();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(LucideIcons.download, size: 16),
                  ),
                  Text('Download'),
                ],
              ),
            ),
          DownloadingState(progress: final progress, isPaused: true) =>
            ShadButton(
              onPressed: () async {
                HapticFeedback.selectionClick();
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .resumeDownload();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(LucideIcons.play, size: 16),
                  ),
                  Text("Paused ${(progress.currentProgress * 100).toInt()}%"),
                ],
              ),
            ),
          DownloadingState(progress: final progress, isPaused: false) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${FileSize.getSize(progress.speed.toInt())}/s",
                      style: ShadTheme.of(context)
                          .textTheme
                          .muted
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    ShadButton.ghost(
                      size: ShadButtonSize.sm,
                      width: 32,
                      height: 32,
                      onPressed: () async {
                        HapticFeedback.selectionClick();
                        ref
                            .read(fileDownloaderPod(widget.filepath).notifier)
                            .pauseDownload();
                      },
                      child: const Icon(LucideIcons.pause, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 120,
                  child: ShadProgress(
                    value: progress.currentProgress,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${prettyDuration(
                    Duration(seconds: progress.remainTime.toInt()),
                    abbreviated: true,
                    upperTersity: DurationTersity.minute,
                  )} remaining",
                  style: ShadTheme.of(context)
                      .textTheme
                      .muted
                      .copyWith(fontSize: 10),
                ),
              ],
            ),
          CompletedDownloadState() => ShadButton(
              onPressed: () async {
                HapticFeedback.heavyImpact();
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .openFile();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(LucideIcons.check, size: 16),
                  ),
                  Text('Open'),
                ],
              ),
            ),
          ErrorDownloadState(:final message) => ShadTooltip(
              builder: (context) => Text(message ?? 'Unknown error'),
              child: ShadButton.destructive(
                onPressed: () async {
                  ref
                      .read(fileDownloaderPod(widget.filepath).notifier)
                      .resetDownload();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(LucideIcons.refreshCw, size: 16),
                    ),
                    Text('Retry'),
                  ],
                ),
              ),
            ),
          MergeDoneState(:final isCompleted) => isCompleted
              ? ShadButton(
                  onPressed: () async {
                    ref
                        .read(fileDownloaderPod(widget.filepath).notifier)
                        .openFile();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(LucideIcons.check, size: 16),
                      ),
                      Text('Open'),
                    ],
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Stitching...",
                      style: ShadTheme.of(context)
                          .textTheme
                          .muted
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
        };
      },
      loadingWidget: () => const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (error, stackTrace) => ShadTooltip(
        builder: (context) => Text(error.toString()),
        child: ShadButton.destructive(
          onPressed: () async {
            ref
                .read(fileDownloaderPod(widget.filepath).notifier)
                .resetDownload();
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(LucideIcons.refreshCw, size: 16),
              ),
              Text('Retry'),
            ],
          ),
        ),
      ),
    );
  }
}
