import 'dart:convert';

import 'package:flutter/foundation.dart';

class ServerInfo {
  final String ip;
  final List<String> allIps;
  final int port;
  final String host;
  final String deviceName;
  final String deviceUUID;
  final String os;
  final String version;
  ServerInfo({
    required this.ip,
    this.allIps = const [],
    required this.port,
    required this.host,
    required this.deviceName,
    required this.deviceUUID,
    required this.os,
    required this.version,
  });

  ServerInfo copyWith({
    String? ip,
    List<String>? allIps,
    int? port,
    String? host,
    String? deviceName,
    String? deviceUUID,
    String? os,
    String? version,
  }) {
    return ServerInfo(
      ip: ip ?? this.ip,
      allIps: allIps ?? this.allIps,
      port: port ?? this.port,
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
      'allIps': allIps,
      'port': port,
      'host': host,
      'deviceName': deviceName,
      'deviceUUID': deviceUUID,
      'os': os,
      'version': version,
    };
  }

  factory ServerInfo.fromMap(Map<String, dynamic> map) {
    return ServerInfo(
      ip: map['ip'] ?? '',
      allIps: List<String>.from(map['allIps'] ?? []),
      port: map['port']?.toInt() ?? 0,
      host: map['host'] ?? '',
      deviceName: map['deviceName'] ?? '',
      deviceUUID: map['deviceUUID'] ?? '',
      os: map['os'] ?? '',
      version: map['version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerInfo.fromJson(String source) =>
      ServerInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServerInfo(ip: $ip, allIps: $allIps, port: $port, host: $host, deviceName: $deviceName, deviceUUID: $deviceUUID, os: $os, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerInfo &&
        other.ip == ip &&
        listEquals(other.allIps, allIps) &&
        other.port == port &&
        other.host == host &&
        other.deviceName == deviceName &&
        other.deviceUUID == deviceUUID &&
        other.os == os &&
        other.version == version;
  }

  @override
  int get hashCode {
    return ip.hashCode ^
        allIps.hashCode ^
        port.hashCode ^
        host.hashCode ^
        deviceName.hashCode ^
        deviceUUID.hashCode ^
        os.hashCode ^
        version.hashCode;
  }
}
