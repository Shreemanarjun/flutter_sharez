import 'dart:convert';

class SenderModel {
  final String ip;
  final int port;
  final int filesCount;
  final String host;
  final String deviceName;
  final String deviceUUID;
  final String os;
  final String version;
  SenderModel({
    required this.ip,
    required this.port,
    required this.filesCount,
    required this.host,
    required this.deviceName,
    required this.deviceUUID,
    required this.os,
    required this.version,
  });

  SenderModel copyWith({
    String? ip,
    int? port,
    int? filesCount,
    String? host,
    String? deviceName,
    String? deviceUUID,
    String? os,
    String? version,
  }) {
    return SenderModel(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      filesCount: filesCount ?? this.filesCount,
      host: host ?? this.host,
      deviceName: deviceName ?? this.deviceName,
      deviceUUID: deviceUUID ?? this.deviceUUID,
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
      'deviceName': deviceName,
      'deviceUUID': deviceUUID,
      'os': os,
      'version': version,
    };
  }

  factory SenderModel.fromMap(Map<String, dynamic> map) {
    return SenderModel(
      ip: map['ip'] ?? '',
      port: map['port']?.toInt() ?? 0,
      filesCount: map['filesCount']?.toInt() ?? 0,
      host: map['host'] ?? '',
      deviceName: map['deviceName'] ?? '',
      deviceUUID: map['deviceUUID'] ?? '',
      os: map['os'] ?? '',
      version: map['version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SenderModel.fromJson(String source) =>
      SenderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SenderModel(ip: $ip, port: $port, filesCount: $filesCount, host: $host, deviceName: $deviceName, deviceUUID: $deviceUUID, os: $os, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SenderModel &&
        other.ip == ip &&
        other.port == port &&
        other.filesCount == filesCount &&
        other.host == host &&
        other.deviceName == deviceName &&
        other.deviceUUID == deviceUUID &&
        other.os == os &&
        other.version == version;
  }

  @override
  int get hashCode {
    return ip.hashCode ^
        port.hashCode ^
        filesCount.hashCode ^
        host.hashCode ^
        deviceName.hashCode ^
        deviceUUID.hashCode ^
        os.hashCode ^
        version.hashCode;
  }
}
