// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

///This is the base class exception which can be
///used to throw with a message
class BaseException implements Exception {
  BaseException({this.message = 'Unknown Error'});
  final String message;
}

///This class used to throw error from API Providers
class APIException implements BaseException {
  final int? statusCode;
  final String? statusMessage;
  final String errorMessage;
  APIException({
    this.statusCode,
    this.statusMessage,
    required this.errorMessage,
  });

  APIException copyWith({
    int? statusCode,
    String? statusMessage,
    String? errorMessage,
  }) {
    return APIException(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'errorMessage': errorMessage,
    };
  }

  factory APIException.fromMap(Map<String, dynamic> map) {
    return APIException(
      statusCode: map['statusCode']?.toInt(),
      statusMessage: map['statusMessage'],
      errorMessage: map['errorMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory APIException.fromJson(String source) =>
      APIException.fromMap(json.decode(source));

  @override
  String toString() =>
      'APIException(statusCode: $statusCode, statusMessage: $statusMessage, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is APIException &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      statusCode.hashCode ^ statusMessage.hashCode ^ errorMessage.hashCode;

  @override
  String get message => errorMessage;
}
