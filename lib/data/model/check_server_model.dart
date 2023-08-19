import 'dart:convert';

class CheckServerModel {
  final String message;
  final String? token;
  CheckServerModel({
    required this.message,
    this.token,
  });

  CheckServerModel copyWith({
    String? message,
    String? token,
  }) {
    return CheckServerModel(
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'token': token,
    };
  }

  factory CheckServerModel.fromMap(Map<String, dynamic> map) {
    return CheckServerModel(
      message: map['message'] ?? '',
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckServerModel.fromJson(String source) =>
      CheckServerModel.fromMap(json.decode(source));

  @override
  String toString() => 'CheckServerModel(message: $message, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckServerModel &&
        other.message == message &&
        other.token == token;
  }

  @override
  int get hashCode => message.hashCode ^ token.hashCode;
}
