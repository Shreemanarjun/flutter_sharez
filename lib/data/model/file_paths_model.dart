import 'dart:convert';

import 'package:flutter/foundation.dart';

class FilePathsModel {
  final List<FilePath> paths;
  FilePathsModel({
    required this.paths,
  });

  FilePathsModel copyWith({
    List<FilePath>? paths,
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
      paths: List<FilePath>.from(map['paths']?.map((x) => FilePath.fromMap(x))),
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

class FilePath {
  final DownloadFile file;
  final String link;
  FilePath({
    required this.file,
    required this.link,
  });

  FilePath copyWith({
    DownloadFile? file,
    String? link,
  }) {
    return FilePath(
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

  factory FilePath.fromMap(Map<String, dynamic> map) {
    return FilePath(
      file: DownloadFile.fromMap(map['file']),
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FilePath.fromJson(String source) =>
      FilePath.fromMap(json.decode(source));

  @override
  String toString() => 'Path(file: $file, link: $link)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilePath && other.file == file && other.link == link;
  }

  @override
  int get hashCode => file.hashCode ^ link.hashCode;
}

class DownloadFile {
  final String name;
  final int size;
  final String fileExt;
  DownloadFile({
    required this.name,
    required this.size,
    required this.fileExt,
  });

  DownloadFile copyWith({
    String? name,
    int? size,
    String? fileExt,
  }) {
    return DownloadFile(
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

  factory DownloadFile.fromMap(Map<String, dynamic> map) {
    return DownloadFile(
      name: map['name'] ?? '',
      size: map['size']?.toInt() ?? 0,
      fileExt: map['fileExt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadFile.fromJson(String source) =>
      DownloadFile.fromMap(json.decode(source));

  @override
  String toString() => 'File(name: $name, size: $size, fileExt: $fileExt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadFile &&
        other.name == name &&
        other.size == size &&
        other.fileExt == fileExt;
  }

  @override
  int get hashCode => name.hashCode ^ size.hashCode ^ fileExt.hashCode;
}
