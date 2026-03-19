import 'package:auto_route/auto_route.dart';

import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/device_share/controller/files_list_pods.dart';
import 'package:flutter_sharez/features/file_download_btn/view/file_download_btn.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/translation_pod.dart';

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
              child: Text(
                t.receiveShareFiles(n: filePathsModel.paths.length),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
                    return ListTile(
                      title: Text(
                        filepath.file.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        "size: ${FileSize.getSize(filepath.file.size)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: FileDownloadBtn(
                        filepath: filepath,
                      ),
                      isThreeLine: true,
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
