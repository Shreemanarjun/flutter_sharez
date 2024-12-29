import 'package:duration/duration.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/file_download_pod.dart';
import 'package:flutter_sharez/features/file_download_btn/state/file_download_state.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

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
        final ({
          Progress progress,
          bool isPaused,
          bool isCompleted,
          bool isError
        }) record = (
          progress: downloadState.progress,
          isPaused: downloadState.isPaused,
          isCompleted: downloadState.isCompleted,
          isError: downloadState.isError
        );
        return switch (record) {
          //Intital download
          (
            progress: Progress(currentProgress: 0, speed: 0, remainTime: 0),
            isPaused: false,
            isCompleted: false,
            isError: false
          ) =>
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .startDownload();
              },
              child: const Icon(
                Icons.file_download_outlined,
              ),
            ),
          //paused
          (
            :final Progress progress,
            isPaused: true,
            isCompleted: _,
            isError: _
          ) =>
            ElevatedButton.icon(
              onPressed: () async {
                ref
                    .read(fileDownloaderPod(widget.filepath).notifier)
                    .resumeDownload();
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label:
                  "${(progress.currentProgress * 100).toInt()} %".text.make(),
            ),
          //downloading
          (
            :final Progress progress,
            isPaused: false,
            isCompleted: false,
            isError: false
          ) =>
            [
              ElevatedButton.icon(
                onPressed: () async {
                  ref
                      .read(fileDownloaderPod(widget.filepath).notifier)
                      .pauseDownload();
                },
                icon: const Icon(Icons.pause),
                label: CircularProgressIndicator(
                  value: progress.currentProgress,
                  color: Colors.green,
                ).p8().fittedBox(),
              ).expand(flex: 3),
              // FileSize.getBytes(progress.speed).text.make(),
              prettyDuration(
                Duration(seconds: progress.remainTime.toInt()),
                abbreviated: true,
                upperTersity: DurationTersity.minute,
              ).text.xs.make().flexible(),
              "${FileSize.getSize(progress.speed.toInt())}/s"
                  .text
                  .xs
                  .make()
                  .flexible(),
            ].vStack(
              alignment: MainAxisAlignment.start,
            ),
          //downloaded
          (
            progress: _,
            isPaused: false,
            isCompleted: true,
            isError: false,
          ) =>
            ElevatedButton(
                onPressed: () async {
                  ref
                      .read(fileDownloaderPod(widget.filepath).notifier)
                      .openFile();
                },
                child: const Icon(Icons.download_done)),
          //Error downloading
          (progress: _, isPaused: false, isCompleted: false, isError: true) =>
            TextButton.icon(
                onPressed: () async {
                  ref
                      .read(fileDownloaderPod(widget.filepath).notifier)
                      .resetDownload();
                },
                label: 'Retry'.text.make(),
                icon: const Icon(Icons.file_download_outlined)),
          (progress: _, isPaused: _, isCompleted: _, isError: _) =>
            TextButton.icon(
                onPressed: () async {
                  ref
                      .read(fileDownloaderPod(widget.filepath).notifier)
                      .resetDownload();
                },
                label: 'Unknow Error . Retry'.text.make(),
                icon: const Icon(Icons.file_download_outlined))
        };
      },
      loadingWidget: () => ElevatedButton(
          onPressed: () async {},
          child: const CircularProgressIndicator().h(24).w(24)),
      errorWidget: (error, stackTrace) => TextButton.icon(
          onPressed: () async {
            ref
                .read(fileDownloaderPod(widget.filepath).notifier)
                .resumeDownload();
          },
          label: 'Retry'.text.make(),
          icon: const Icon(Icons.file_download_outlined)),
    );
  }
}
