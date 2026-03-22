import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_paths_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/device_share/controller/files_list_pods.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/downloads_queue_pod.dart';
import 'package:flutter_sharez/features/file_download_btn/view/file_download_btn.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/shared/widget/file_icon.dart';
import 'package:flutter_sharez/shared/widget/skeleton_file_loader.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:vibration/vibration.dart';

@RoutePage(
  deferredLoading: true,
)
class SenderFilesTabPage extends ConsumerStatefulWidget {
  final SenderModel senderModel;
  const SenderFilesTabPage({super.key, required this.senderModel});

  @override
  ConsumerState<SenderFilesTabPage> createState() => _SenderFilesTabPageState();
}

class _SenderFilesTabPageState extends ConsumerState<SenderFilesTabPage>
    with GlobalHelper, SingleTickerProviderStateMixin {
  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filesAsync = ref.watch(senderfileListPod(widget.senderModel));
    final t = ref.watch(translationsPod);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    return filesAsync.easyWhen(
      loadingWidget: () => const SkeletonFileLoader(),
      data: (filePathsModel) {
        if (filePathsModel.paths.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.folderOpen, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  "No files shared by sender",
                  style: ShadTheme.of(context).textTheme.muted,
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      t.receiveShareFiles(n: filePathsModel.paths.length),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ShadButton.outline(
                    onPressed: () {
                      _vibrate();
                      ref
                          .read(downloadsQueuePod.notifier)
                          .downloadAll(filePathsModel.paths);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.download, size: 16),
                        SizedBox(width: 8),
                        Text("Download All"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(senderfileListPod(widget.senderModel));
                },
                child: isDesktop
                    ? _buildGridView(filePathsModel)
                    : _buildListView(filePathsModel),
              ),
            )
          ],
        );
      },
      onRetry: () {
        ref.invalidate(senderfileListPod(widget.senderModel));
      },
    );
  }

  Widget _buildListView(FilePathsModel filePathsModel) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 60, left: 8, right: 8),
      itemCount: filePathsModel.paths.length,
      itemBuilder: (context, index) {
        final filepath = filePathsModel.paths[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ShadCard(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                FileIcon(fileName: filepath.file.name),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filepath.file.name,
                        style: ShadTheme.of(context).textTheme.p.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FileSize.getSize(filepath.file.size),
                        style: ShadTheme.of(context)
                            .textTheme
                            .muted
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                FileDownloadBtn(filepath: filepath),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(FilePathsModel filePathsModel) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 60, left: 16, right: 16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 100,
      ),
      itemCount: filePathsModel.paths.length,
      itemBuilder: (context, index) {
        final filepath = filePathsModel.paths[index];
        return ShadCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              FileIcon(fileName: filepath.file.name, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filepath.file.name,
                      style: ShadTheme.of(context).textTheme.p.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      FileSize.getSize(filepath.file.size),
                      style: ShadTheme.of(context)
                          .textTheme
                          .muted
                          .copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FileDownloadBtn(filepath: filepath),
            ],
          ),
        );
      },
    );
  }
}
