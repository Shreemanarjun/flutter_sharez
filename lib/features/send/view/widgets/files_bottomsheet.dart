import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/shared/widget/file_icon.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lottie/lottie.dart';

class FilesBottomsheetView extends ConsumerStatefulWidget {
  const FilesBottomsheetView({super.key});

  @override
  ConsumerState<FilesBottomsheetView> createState() =>
      _FilesBottomsheetViewState();
}

class _FilesBottomsheetViewState extends ConsumerState<FilesBottomsheetView> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedfiles = ref.watch(selectedFilesPod);
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);

    if (selectedfiles.isNotEmpty) {
      final totalSize = selectedfiles.fold<int>(
        0,
        (previousValue, element) => previousValue + element.file.size,
      );

      return ShadSheet(
        backgroundColor: theme.colorScheme.background,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width,
            maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        title: Text("${selectedfiles.length} Files Selected"),
        description: Text("Total Size: ${FileSize.getSize(totalSize)}"),
        actionsAxis: Axis.vertical,
        actions: [
          ShadButton(
            width: double.infinity,
            onPressed: () => Navigator.pop(context),
            child: const Text("Done"),
          ),
        ],
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(height: 1),
              Flexible(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: selectedfiles.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final file = selectedfiles[index];
                      return _FileItemTile(
                        fileName: file.file.name,
                        size: file.file.size,
                        onTap: () {
                          if (file.file.path != null) {
                            OpenFilex.open(file.file.path!);
                          }
                        },
                        onDelete: () =>
                            ref.read(selectedFilesPod.notifier).deleteItem(index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ShadSheet(
        backgroundColor: theme.colorScheme.background,
        title: Text(t.noFileSelected),
        description: const Text("Add some files to start sharing your world!"),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 160,
                child: Lottie.asset(
                  'assets/anim/empty_state.json',
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(LucideIcons.fileX, size: 80, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              ShadButton(
                onPressed: () => Navigator.pop(context),
                child: Text(t.addFiles),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _FileItemTile extends StatelessWidget {
  final String fileName;
  final int size;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _FileItemTile({
    required this.fileName,
    required this.size,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.border.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                FileIcon(fileName: fileName, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: theme.textTheme.p.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        FileSize.getSize(size),
                        style: theme.textTheme.muted.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ShadIconButton.ghost(
                  icon: const Icon(LucideIcons.x, size: 18),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
