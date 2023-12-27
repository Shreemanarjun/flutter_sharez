import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/file_selector/view/file_list_view.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class FileSelectorPage extends ConsumerStatefulWidget {
  const FileSelectorPage({super.key});

  @override
  ConsumerState<FileSelectorPage> createState() => _FileSelectorState();
}

class _FileSelectorState extends ConsumerState<FileSelectorPage>
    with GlobalHelper {
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
                  child: const Icon(Icons.share),
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
                      height: context.safePercentHeight * 25,
                      addRepaintBoundary: true),
                  context.l10n.noFilesSelectedYet.text.bold.makeCentered()
                ].vStack(
                  alignment: MainAxisAlignment.center,
                  crossAlignment: CrossAxisAlignment.center);
        },
      ),
    );
  }
}
