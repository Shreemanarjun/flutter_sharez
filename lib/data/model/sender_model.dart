import 'dart:convert';

class SenderModel {
  final String? ip;
  final int? port;
  final int? filesCount;
  final String? host;
  final String? os;
  final String? version;
  SenderModel({
    this.ip,
    this.port,
    this.filesCount,
    this.host,
    this.os,
    this.version,
  });

  SenderModel copyWith({
    String? ip,
    int? port,
    int? filesCount,
    String? host,
    String? os,
    String? version,
  }) {
    return SenderModel(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      filesCount: filesCount ?? this.filesCount,
      host: host ?? this.host,
      os: os ?? this.os,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'port': port,
      'filesCount': filesCount,
      'host': host,
      'os': os,
      'version': version,
    };
  }

  factory SenderModel.fromMap(Map<String, dynamic> map) {
    return SenderModel(
      ip: map['ip'],
      port: map['port']?.toInt(),
      filesCount: map['filesCount']?.toInt(),
      host: map['host'],
      os: map['os'],
      version: map['version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SenderModel.fromJson(String source) =>
      SenderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SenderModel(ip: $ip, port: $port, filesCount: $filesCount, host: $host, os: $os, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SenderModel &&
        other.ip == ip &&
        other.port == port &&
        other.filesCount == filesCount &&
        other.host == host &&
        other.os == os &&
        other.version == version;
  }

  @override
  int get hashCode {
    return ip.hashCode ^
        port.hashCode ^
        filesCount.hashCode ^
        host.hashCode ^
        os.hashCode ^
        version.hashCode;
  }
}
