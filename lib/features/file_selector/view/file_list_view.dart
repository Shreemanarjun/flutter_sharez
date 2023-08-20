import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class FileListView extends StatelessWidget {
  final List<FileSelectModel> files;
  const FileListView({Key? key, required this.files}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: files.length,
      padding: const EdgeInsets.only(
        bottom: 80,
        top: 16,
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final file = files[index];
        return ListTile(
          minVerticalPadding: 0,
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
                    ref.read(selectedFilesPod.notifier).deleteItem(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Vx.red400,
                  ));
            },
          ),
        );
      },
    );
  }
}
