import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:platform_info/platform_info.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesListNotifier extends Notifier<List<FileSelectModel>> {
  var _isPickerAlreadyOpened = false;
  @override
  List<FileSelectModel> build() {
    return [];
  }

  Future<void> selectFiles({
    required void Function(String error) onError,
  }) async {
    if (!_isPickerAlreadyOpened) {
      try {
        _isPickerAlreadyOpened = true;
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          withReadStream: false,
          withData: false,
          lockParentWindow: true,
        );
        if (result != null) {
          final existingPaths = state.map((m) => m.file.path).toSet();
          final List<FileSelectModel> newFiles = [];

          for (final f in result.files) {
            if (f.path != null && !existingPaths.contains(f.path)) {
              newFiles.add(FileSelectModel(isSelected: false, file: f));
            }
          }
          state = [...state, ...newFiles];
        }
      } finally {
        _isPickerAlreadyOpened = false;
      }
    }
  }

  Future<void> selectFolder({
    required void Function(String error) onError,
  }) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
        lockParentWindow: true,
      );
      if (selectedDirectory != null) {
        final dir = Directory(selectedDirectory);
        final folderName = p.basename(selectedDirectory);
        final tempDir = await getTemporaryDirectory();
        final zipPath = p.join(tempDir.path, "$folderName.zip");

        final encoder = ZipFileEncoder();
        encoder.create(zipPath);
        await encoder.addDirectory(dir);
        encoder.close();

        final file = File(zipPath);
        final size = await file.length();
        final platformFile = PlatformFile(
          path: zipPath,
          name: "$folderName.zip",
          size: size,
        );
        addFile(platformFile);
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> addClipboardContent({
    required void Function(String error) onError,
  }) async {
    try {
      final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data?.text != null) {
        final content = data!.text!;
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filePath = p.join(tempDir.path, "clipboard_$timestamp.txt");
        final file = File(filePath);
        await file.writeAsString(content);

        final platformFile = PlatformFile(
          path: filePath,
          name: "clipboard_$timestamp.txt",
          size: await file.length(),
        );
        addFile(platformFile);
      } else {
        onError("Clipboard is empty or doesn't contain text");
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  void addFile(PlatformFile file) {
    if (file.path == null) return;
    final exists = state.any((e) => e.file.path == file.path);
    if (!exists) {
      state = [...state, FileSelectModel(isSelected: false, file: file)];
    }
  }

  void addFiles(List<PlatformFile> files) {
    final existingPaths = state.map((m) => m.file.path).toSet();
    final List<FileSelectModel> newFiles = [];
    for (final f in files) {
      if (f.path != null && !existingPaths.contains(f.path)) {
        newFiles.add(FileSelectModel(isSelected: false, file: f));
      }
    }
    state = [...state, ...newFiles];
  }

  void deleteItem(int index) {
    final list = List<FileSelectModel>.from(state);
    list.removeAt(index);
    state = list;
  }

  void resetState() {
    state = [];
  }

  Future<bool> checkFilePermission({
    required void Function(String error) onError,
  }) async {
    if (platform.js || platform.desktop) {
      return true;
    } else {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        try {
          final photoStatus = await Permission.photos.status;
          final externalStorage = await Permission.manageExternalStorage.status;
          talker.debug(externalStorage);
          talker.debug(photoStatus);
          final status = await Permission.storage.status;
          switch (status) {
            case PermissionStatus.denied:
              onError('Permisson Denied');
              openAppSettings();
              return false;
            case PermissionStatus.granted:
              return true;
            case PermissionStatus.restricted:
              onError('Permisson Restricted');
              return false;
            case PermissionStatus.limited:
              onError('Permisson Restricted');
              return false;
            case PermissionStatus.permanentlyDenied:
              onError('Permisson Restricted');
              return false;
            case PermissionStatus.provisional:
              onError('Provisionally restricted');
              return false;
          }
        } on Exception catch (e) {
          onError(e.toString());
          return false;
        }
      }
    }
  }
}
