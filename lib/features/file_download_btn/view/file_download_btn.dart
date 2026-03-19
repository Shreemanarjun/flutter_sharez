import 'package:duration/duration.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/file_download_pod.dart';
import 'package:flutter_sharez/features/file_download_btn/state/file_download_state.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';

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
          InitialDownloadState() => ElevatedButton(
              onPressed: () async {
                await ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .startDownload();
              },
              child: const Icon(
                Icons.file_download_outlined,
              ),
            ),
          DownloadingState(progress: final progress, isPaused: true) =>
            ElevatedButton.icon(
              onPressed: () async {
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .resumeDownload();
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: Text("${(progress.currentProgress * 100).toInt()} %"),
            ),
          DownloadingState(progress: final progress, isPaused: false) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      ref
                          .read(fileDownloaderPod(widget.filepath).notifier)
                          .pauseDownload();
                    },
                    icon: const Icon(Icons.pause),
                    label: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          value: progress.currentProgress,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    prettyDuration(
                      Duration(seconds: progress.remainTime.toInt()),
                      abbreviated: true,
                      upperTersity: DurationTersity.minute,
                    ),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${FileSize.getSize(progress.speed.toInt())}/s",
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          CompletedDownloadState() => ElevatedButton(
              onPressed: () async {
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .openFile();
              },
              child: const Icon(Icons.download_done),
            ),
          ErrorDownloadState() => TextButton.icon(
              onPressed: () async {
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .resetDownload();
              },
              label: const Text('Unknow Error . Retry'),
              icon: const Icon(Icons.file_download_outlined)),
          MergeDoneState(:final isCompleted) => isCompleted
              ? ElevatedButton(
                  onPressed: () async {
                    ref
                        .read(fileDownloaderPod(widget.filepath).notifier)
                        .openFile();
                  },
                  child: const Icon(Icons.download_done),
                )
              : const Text("Merging .Please wait"),
        };
      },
      loadingWidget: () => ElevatedButton(
        onPressed: () async {},
        child: const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (error, stackTrace) => TextButton.icon(
          onPressed: () async {
            ref
                .read(fileDownloaderPod(widget.filepath).notifier)
                .resumeDownload();
          },
          label: const Text('Retry'),
          icon: const Icon(Icons.file_download_outlined)),
    );
  }
}
