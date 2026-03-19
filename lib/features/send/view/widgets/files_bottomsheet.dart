import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';

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
    if (selectedfiles.isNotEmpty) {
      return Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${selectedfiles.length} files selected",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: ListView.separated(
                controller: scrollController,
                itemCount: selectedfiles.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final file = selectedfiles[index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(file.file.name),
                    subtitle: Text("size: ${FileSize.getSize(file.file.size)}"),
                    trailing: Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          onPressed: () {
                            ref
                                .read(selectedFilesPod.notifier)
                                .deleteItem(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                t.noFileSelected,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  // final sendprovider = ref.read(sendProvider.notifier);
                  // sendprovider.addFiles();
                },
                child: Text(t.addFiles),
              ),
            )
          ],
        ),
      );
    }
  }
}
