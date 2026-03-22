import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

class FileListView extends StatelessWidget {
  final List<FileSelectModel> files;
  const FileListView({super.key, required this.files});

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
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(file.file.name),
          subtitle: Text("size: ${FileSize.getSize(file.file.size)}"),
          trailing: Consumer(
            builder: (context, ref, child) {
              return IconButton(
                  onPressed: () {
                    ref.read(selectedFilesPod.notifier).deleteItem(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ));
            },
          ),
        );
      },
    );
  }
}
