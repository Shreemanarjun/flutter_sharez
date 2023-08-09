import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

import 'package:velocity_x/velocity_x.dart';

class FilesBottomsheetView extends ConsumerWidget {
  const FilesBottomsheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final selectedfiles = ref.watch(selectedFilesPod);

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
              child: ListView.separated(
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
        "No files selected".text.xl.makeCentered(),
        ElevatedButton(
          onPressed: () {
            // final sendprovider = ref.read(sendProvider.notifier);
            // sendprovider.addFiles();
          },
          child: 'Add files'.text.make(),
        ).p12()
      ].vStack().p16();
    }
  }
}
