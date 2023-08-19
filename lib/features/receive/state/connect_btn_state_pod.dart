import 'dart:convert';

sealed class ConnectBtnState {
  const ConnectBtnState();
}

class UnconnectedState implements ConnectBtnState {}

class ConnectingState implements ConnectBtnState {}

class ConenctionAcceptanceState implements ConnectBtnState {
  final bool isAccepted;
  ConenctionAcceptanceState({
    required this.isAccepted,
  });

  ConenctionAcceptanceState copyWith({
    bool? isAccepted,
  }) {
    return ConenctionAcceptanceState(
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAccepted': isAccepted,
    };
  }

  factory ConenctionAcceptanceState.fromMap(Map<String, dynamic> map) {
    return ConenctionAcceptanceState(
      isAccepted: map['isAccepted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConenctionAcceptanceState.fromJson(String source) =>
      ConenctionAcceptanceState.fromMap(json.decode(source));

  @override
  String toString() => 'ConenctionAcceptanceState(isAccepted: $isAccepted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConenctionAcceptanceState && other.isAccepted == isAccepted;
  }

  @override
  int get hashCode => isAccepted.hashCode;
}

class ConnectionFailedState implements ConnectBtnState {
  final String message;
  ConnectionFailedState({
    required this.message,
  });

  ConnectionFailedState copyWith({
    String? message,
  }) {
    return ConnectionFailedState(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ConnectionFailedState.fromMap(Map<String, dynamic> map) {
    return ConnectionFailedState(
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionFailedState.fromJson(String source) =>
      ConnectionFailedState.fromMap(json.decode(source));

  @override
  String toString() => 'ConnectionFailedState(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConnectionFailedState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
