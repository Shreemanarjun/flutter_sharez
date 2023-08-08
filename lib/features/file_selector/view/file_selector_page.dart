import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/file_selector/view/file_list_view.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class FileSelector extends ConsumerStatefulWidget {
  const FileSelector({Key? key}) : super(key: key);

  @override
  ConsumerState<FileSelector> createState() => _FileSelectorState();
}

class _FileSelectorState extends ConsumerState<FileSelector> with GlobalHelper {
  Future<void> selectFiles() async {
    ref.read(selectedFilesPod.notifier).selectFiles(
      onError: (error) {
        showErrorSnack(child: error.text.isIntrinsic.make());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final files = ref.watch(selectedFilesPod);
    return Scaffold(
      appBar: CustomAppBar(
        appActions: [
          IconButton(
            onPressed: () {
              context.navigateTo(const DownloadsRoute());
            },
            icon: const Icon(
              Icons.download_outlined,
            ),
            tooltip: 'Downloads',
          ),
          IconButton(
            onPressed: () {
              context.navigateTo(const SettingsRoute());
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'App Settings',
          ),
        ],
      ),
      floatingActionButton: files.isNotEmpty
          ? Wrap(
              children: [
                FloatingActionButton(
                  heroTag: 'add more',
                  onPressed: selectFiles,
                  child: const Icon(Icons.add),
                ),
                20.widthBox,
                FloatingActionButton(
                  heroTag: 'send',
                  onPressed: () {
                    context.navigateTo(const SendStateRoute());
                  },
                  child: const Icon(Icons.send_rounded),
                )
              ],
            )
          : FloatingActionButton(
              heroTag: 'add',
              onPressed: selectFiles,
              child: const Icon(Icons.add),
            ),
      body: Consumer(
        builder: (context, ref, child) {
          final files = ref.watch(selectedFilesPod);
          return files.isNotEmpty
              ? FileListView(files: files)
              : <Widget>[
                  Lottie.asset('assets/anim/files.json',
                      height: context.safePercentHeight * 25),
                  "No files selected yet".text.bold.makeCentered()
                ].vStack(
                  alignment: MainAxisAlignment.center,
                  crossAlignment: CrossAxisAlignment.center);
        },
      ),
    );
  }
}
