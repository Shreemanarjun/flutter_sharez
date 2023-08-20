import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/device_share/controller/files_list_pods.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';

import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SenderFilesTabPage extends ConsumerStatefulWidget {
  final SenderModel senderModel;
  const SenderFilesTabPage({Key? key, required this.senderModel})
      : super(key: key);

  @override
  ConsumerState<SenderFilesTabPage> createState() => _SenderFilesTabPageState();
}

class _SenderFilesTabPageState extends ConsumerState<SenderFilesTabPage>
    with GlobalHelper, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final filesAsync = ref.watch(senderfileListPod(widget.senderModel));
    return filesAsync.easyWhen(
      data: (filePathsModel) {
        return [
          "${filePathsModel.paths.length} ${filePathsModel.paths.length == 1 ? "file" : "files"} shared"
              .text
              .bold
              .lg
              .make()
              .p4(),
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(senderfileListPod(widget.senderModel));
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 60),
                itemBuilder: (mcontext, index) {
                  final filepath = filePathsModel.paths[index];
                  return ListTile(
                      title: filepath.file.name.text.make(),
                      subtitle: "size: ${FileSize.getSize(filepath.file.size)}"
                          .toString()
                          .text
                          .make(),
                      isThreeLine: true,
                      trailing: ElevatedButton(
                        onPressed: () async {},
                        child: const Icon(
                          Icons.file_download_outlined,
                        ),
                      ));
                },
                itemCount: filePathsModel.paths.length,
              ),
            ),
          )
        ].vStack();
      },
    );
  }
}
