import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/file_selector/view/file_list_view.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:lottie/lottie.dart';

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
        showErrorSnack(
          child: Text(
            error,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
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
                const SizedBox(width: 20),
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
          final t = ref.watch(translationsPod);
          final files = ref.watch(selectedFilesPod);
          return files.isNotEmpty
              ? FileListView(files: files)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/anim/files.json',
                        height: MediaQuery.of(context).size.height * 0.25,
                        addRepaintBoundary: true,
                      ),
                      Center(
                        child: Text(
                          t.noFileSelected,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
