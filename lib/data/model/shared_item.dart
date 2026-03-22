import 'dart:convert';

class SharedItem {
  final String name;
  final int size;
  final String path;
  final DateTime shareDate;

  SharedItem({
    required this.name,
    required this.size,
    required this.path,
    required this.shareDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'size': size,
      'path': path,
      'shareDate': shareDate.millisecondsSinceEpoch,
    };
  }

  factory SharedItem.fromMap(Map<String, dynamic> map) {
    return SharedItem(
      name: map['name'] ?? '',
      size: map['size']?.toInt() ?? 0,
      path: map['path'] ?? '',
      shareDate: DateTime.fromMillisecondsSinceEpoch(map['shareDate'] ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory SharedItem.fromJson(String source) =>
      SharedItem.fromMap(json.decode(source));
}
