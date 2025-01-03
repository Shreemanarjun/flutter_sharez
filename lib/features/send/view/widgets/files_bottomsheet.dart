import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:velocity_x/velocity_x.dart';

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
          "${selectedfiles.length} files selected"
              .text
              .xl
              .bold
              .make()
              .objectTopLeft()
              .p16(),
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
                    leading: index
                        .toString()
                        .text
                        .color(context.colors.onSurface)
                        .bold
                        .makeCentered()
                        .circle(
                          radius: 24,
                          backgroundColor: context.colors.surface,
                        ),
                    title: file.file.name.text.make(),
                    subtitle: "size: ${FileSize.getSize(file.file.size)}"
                        .toString()
                        .text
                        .make(),
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
                              color: Vx.red400,
                            ));
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
      return [
        t.no_file_selected.text.xl.makeCentered(),
        ElevatedButton(
          onPressed: () {
            // final sendprovider = ref.read(sendProvider.notifier);
            // sendprovider.addFiles();
          },
          child: t.add_files.text.make(),
        ).p12()
      ].vStack().p16();
    }
  }
}
