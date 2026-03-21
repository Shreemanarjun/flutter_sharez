import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/device_share/controller/files_list_pods.dart';
import 'package:flutter_sharez/features/file_download_btn/controller/downloads_queue_pod.dart';
import 'package:flutter_sharez/features/file_download_btn/view/file_download_btn.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  @override
  Widget build(BuildContext context) {
    final filesAsync = ref.watch(senderfileListPod(widget.senderModel));
    final t = ref.watch(translationsPod);
    return filesAsync.easyWhen(
      data: (filePathsModel) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    t.receiveShareFiles(n: filePathsModel.paths.length),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ShadButton.outline(
                    onPressed: () {
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
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 60),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (mcontext, index) {
                    final filepath = filePathsModel.paths[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6.0),
                      child: ShadCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(LucideIcons.fileText),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filepath.file.name,
                                        style: ShadTheme.of(context)
                                            .textTheme
                                            .h4
                                            .copyWith(
                                              fontSize: 15,
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
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: filePathsModel.paths.length,
                ),
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
}
