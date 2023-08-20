import 'dart:convert';

import 'package:flutter/foundation.dart';

class FilePathsModel {
  final List<Path> paths;
  FilePathsModel({
    required this.paths,
  });

  FilePathsModel copyWith({
    List<Path>? paths,
  }) {
    return FilePathsModel(
      paths: paths ?? this.paths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paths': paths.map((x) => x.toMap()).toList(),
    };
  }

  factory FilePathsModel.fromMap(Map<String, dynamic> map) {
    return FilePathsModel(
      paths: List<Path>.from(map['paths']?.map((x) => Path.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilePathsModel.fromJson(String source) =>
      FilePathsModel.fromMap(json.decode(source));

  @override
  String toString() => 'FilePathsModel(paths: $paths)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilePathsModel && listEquals(other.paths, paths);
  }

  @override
  int get hashCode => paths.hashCode;
}

class Path {
  final File file;
  final String link;
  Path({
    required this.file,
    required this.link,
  });

  Path copyWith({
    File? file,
    String? link,
  }) {
    return Path(
      file: file ?? this.file,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'file': file.toMap(),
      'link': link,
    };
  }

  factory Path.fromMap(Map<String, dynamic> map) {
    return Path(
      file: File.fromMap(map['file']),
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Path.fromJson(String source) => Path.fromMap(json.decode(source));

  @override
  String toString() => 'Path(file: $file, link: $link)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Path && other.file == file && other.link == link;
  }

  @override
  int get hashCode => file.hashCode ^ link.hashCode;
}

class File {
  final String name;
  final int size;
  final String fileExt;
  File({
    required this.name,
    required this.size,
    required this.fileExt,
  });

  File copyWith({
    String? name,
    int? size,
    String? fileExt,
  }) {
    return File(
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

  factory File.fromMap(Map<String, dynamic> map) {
    return File(
      name: map['name'] ?? '',
      size: map['size']?.toInt() ?? 0,
      fileExt: map['fileExt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory File.fromJson(String source) => File.fromMap(json.decode(source));

  @override
  String toString() => 'File(name: $name, size: $size, fileExt: $fileExt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is File &&
        other.name == name &&
        other.size == size &&
        other.fileExt == fileExt;
  }

  @override
  int get hashCode => name.hashCode ^ size.hashCode ^ fileExt.hashCode;
}
