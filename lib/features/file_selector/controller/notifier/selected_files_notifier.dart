import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:platform_info/platform_info.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesListNotifier extends AutoDisposeNotifier<List<FileSelectModel>> {
  var _isPickerAlreadyOpened = false;
  @override
  List<FileSelectModel> build() {
    return [];
  }

  Future<void> selectFiles({
    required void Function(String error) onError,
  }) async {
    if (!_isPickerAlreadyOpened) {
      _isPickerAlreadyOpened = true;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowCompression: false,
        withReadStream: false,
        withData: false,
      );
      if (result != null) {
        final files = result.files
            .map((e) => FileSelectModel(isSelected: false, file: e))
            .toSet()
            .toList();
        state.addAll(files);
        state = state.toList();

        _isPickerAlreadyOpened = false;
      }
    } else {
      _isPickerAlreadyOpened = false;
      return;
    }
  }

  void deleteItem(int index) {
    state.removeAt(index);
    state = state.toList();
  }

  void resetState() {
    state.clear();
  }

  Future<bool> checkFilePermission({
    required void Function(String error) onError,
  }) async {
    if (platform.isWeb || platform.isMacOS) {
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
              onError('Provisionally restrictedß');
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
