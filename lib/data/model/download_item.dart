import 'dart:convert';

class DownloadItem {
  final String name;
  final int size;
  final String path;
  final DateTime downloadDate;
  final bool isCompleted;

  DownloadItem({
    required this.name,
    required this.size,
    required this.path,
    required this.downloadDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'size': size,
      'path': path,
      'downloadDate': downloadDate.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
    };
  }

  factory DownloadItem.fromMap(Map<String, dynamic> map) {
    return DownloadItem(
      name: map['name'] ?? '',
      size: map['size']?.toInt() ?? 0,
      path: map['path'] ?? '',
      downloadDate:
          DateTime.fromMillisecondsSinceEpoch(map['downloadDate'] ?? 0),
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadItem.fromJson(String source) =>
      DownloadItem.fromMap(json.decode(source));
}
