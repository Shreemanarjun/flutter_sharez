import 'dart:convert';

sealed class SendState {
  const SendState();
}

class StartingServer implements SendState {
  const StartingServer();
}

class StartedServer implements SendState {
  const StartedServer();
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
