import 'dart:convert';

class ReceiverModel {
  final String ip;
  final int port;
  final String host;
  final String os;
  final String version;
  ReceiverModel({
    required this.ip,
    required this.port,
    required this.host,
    required this.os,
    required this.version,
  });

  ReceiverModel copyWith({
    String? ip,
    int? port,
    String? host,
    String? os,
    String? version,
  }) {
    return ReceiverModel(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      host: host ?? this.host,
      os: os ?? this.os,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'port': port,
      'host': host,
      'os': os,
      'version': version,
    };
  }

  factory ReceiverModel.fromMap(Map<String, dynamic> map) {
    return ReceiverModel(
      ip: map['ip'] ?? '',
      port: map['port']?.toInt() ?? 0,
      host: map['host'] ?? '',
      os: map['os'] ?? '',
      version: map['version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiverModel.fromJson(String source) =>
      ReceiverModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReceiverModel(ip: $ip, port: $port, host: $host, os: $os, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReceiverModel &&
        other.ip == ip &&
        other.port == port &&
        other.host == host &&
        other.os == os &&
        other.version == version;
  }

  @override
  int get hashCode {
    return ip.hashCode ^
        port.hashCode ^
        host.hashCode ^
        os.hashCode ^
        version.hashCode;
  }
}
