import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:flutter_sharez/features/file_selector/controller/notifier/selected_files_notifier.dart';

final selectedFilesPod =
    NotifierProvider.autoDispose<FilesListNotifier, List<FileSelectModel>>(
  FilesListNotifier.new,
  name: 'selectedFilesPod',
);
