import 'dart:convert';

import 'package:flutter_sharez/data/model/server_info.dart';

sealed class SendState {
  const SendState();
}

class StartingServer implements SendState {
  const StartingServer();
}

class StartedServer implements SendState {
  final ServerInfo serverInfo;
  const StartedServer({
    required this.serverInfo,
  });

  StartedServer copyWith({
    ServerInfo? serverInfo,
  }) {
    return StartedServer(
      serverInfo: serverInfo ?? this.serverInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serverInfo': serverInfo.toMap(),
    };
  }

  factory StartedServer.fromMap(Map<String, dynamic> map) {
    return StartedServer(
      serverInfo: ServerInfo.fromMap(map['serverInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StartedServer.fromJson(String source) =>
      StartedServer.fromMap(json.decode(source));

  @override
  String toString() => 'StartedServer(serverInfo: $serverInfo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StartedServer && other.serverInfo == serverInfo;
  }

  @override
  int get hashCode => serverInfo.hashCode;
}

class StoppedServer implements SendState {
  const StoppedServer();
}

class ServerError implements SendState {
  final String error;
  ServerError({
    required this.error,
  });

  ServerError copyWith({
    String? error,
  }) {
    return ServerError(
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
    };
  }

  factory ServerError.fromMap(Map<String, dynamic> map) {
    return ServerError(
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerError.fromJson(String source) =>
      ServerError.fromMap(json.decode(source));

  @override
  String toString() => 'ServerError(error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerError && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
