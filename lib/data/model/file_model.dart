import 'dart:convert';

class FileModel {
  final String name;
  final int size;

  final String fileExt;
  FileModel({
    required this.name,
    required this.size,
    required this.fileExt,
  });

  FileModel copyWith({
    String? name,
    int? size,
    String? fileExt,
  }) {
    return FileModel(
      name: name ?? this.name,
      size: size ?? this.size,
      fileExt: fileExt ?? this.fileExt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'size': size,
      'fileExt': fileExt,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      name: map['name'] ?? '',
      size: map['size']?.toInt() ?? 0,
      fileExt: map['fileExt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source));

  @override
  String toString() => 'FileModel(name: $name, size: $size, fileExt: $fileExt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModel &&
        other.name == name &&
        other.size == size &&
        other.fileExt == fileExt;
  }

  @override
  int get hashCode => name.hashCode ^ size.hashCode ^ fileExt.hashCode;
}
