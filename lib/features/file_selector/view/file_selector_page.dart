import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/file_selector/view/file_list_view.dart';
import 'package:flutter_sharez/features/send/controller/shared_history_pod.dart';

import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
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
        HapticFeedback.vibrate();
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
                    HapticFeedback.mediumImpact();
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
          final recentFiles = ref.watch(sharedHistoryPod);

          if (files.isNotEmpty) {
            return FileListView(files: files);
          }

          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/anim/files.json',
                        height: MediaQuery.of(context).size.height * 0.25,
                        addRepaintBoundary: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.noFileSelected,
                        style: ShadTheme.of(context)
                            .textTheme
                            .large
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              if (recentFiles.isNotEmpty)
                _buildRecentFilesSection(context, ref, recentFiles, t),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecentFilesSection(
      BuildContext context, WidgetRef ref, List recentFiles, dynamic t) {
    final theme = ShadTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently Shared",
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
                ShadButton.ghost(
                  size: ShadButtonSize.sm,
                  onPressed: () =>
                      ref.read(sharedHistoryPod.notifier).clearHistory(),
                  child: const Text("Clear"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: recentFiles.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = recentFiles[index];
                return GestureDetector(
                  onTap: () =>
                      ref.read(sharedHistoryPod.notifier).reshare(item),
                  child: ShadCard(
                    padding: const EdgeInsets.all(12),
                    width: 200,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            LucideIcons.file,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: theme.textTheme.small.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                FileSize.getSize(item.size),
                                style: theme.textTheme.muted
                                    .copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
