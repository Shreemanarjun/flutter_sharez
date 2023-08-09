import 'package:file_picker/file_picker.dart';

class FileSelectModel {
  final bool isSelected;
  final PlatformFile file;
  FileSelectModel({
    required this.isSelected,
    required this.file,
  });

  FileSelectModel copyWith({
    bool? isSelected,
    PlatformFile? file,
  }) {
    return FileSelectModel(
      isSelected: isSelected ?? this.isSelected,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileSelectModel &&
        other.isSelected == isSelected &&
        other.file == file;
  }

  @override
  int get hashCode => isSelected.hashCode ^ file.hashCode;

  @override
  String toString() => 'FileSelectModel(isSelected: $isSelected, file: $file)';
}
