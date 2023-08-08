import 'dart:convert';

sealed class SelectFileState {
  const SelectFileState();
}

class Initial implements SelectFileState {
  const Initial();
}

class PermissionDenied implements SelectFileState {
  const PermissionDenied();
}

class SelectFiles implements SelectFileState {
  const SelectFiles();
}

class SelectFileStateError implements SelectFileState {
  final String message;
  final String? details;
  SelectFileStateError({
    required this.message,
    this.details,
  });

  SelectFileStateError copyWith({
    String? message,
    String? details,
  }) {
    return SelectFileStateError(
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'details': details,
    };
  }

  factory SelectFileStateError.fromMap(Map<String, dynamic> map) {
    return SelectFileStateError(
      message: map['message'] ?? '',
      details: map['details'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectFileStateError.fromJson(String source) =>
      SelectFileStateError.fromMap(json.decode(source));

  @override
  String toString() =>
      'SelectFileStateError(message: $message, details: $details)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectFileStateError &&
        other.message == message &&
        other.details == details;
  }

  @override
  int get hashCode => message.hashCode ^ details.hashCode;
}
