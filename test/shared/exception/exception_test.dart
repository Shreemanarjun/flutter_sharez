import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';

void main() {
  group('APIException', () {
    test(
        'copyWith() should return a new APIException object with updated values',
        () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final updatedException = exception.copyWith(
        statusCode: 500,
        statusMessage: 'Internal Server Error',
        errorMessage: 'Something went wrong',
      );
      expect(exception != updatedException, true);
      expect(exception.statusCode, 404);
      expect(exception.statusMessage, 'Not Found');
      expect(updatedException.statusCode, 500);
      expect(updatedException.statusMessage, equals('Internal Server Error'));
      expect(updatedException.errorMessage, equals('Something went wrong'));
      final newexception =
          exception.copyWith(statusCode: null, statusMessage: null);
      expect(newexception.statusMessage, 'Not Found');
      expect(newexception.statusCode, 404);
    });

    test('toMap() should return a map representation of the APIException', () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final exceptionMap = exception.toMap();

      expect(exceptionMap['statusCode'], 404);
      expect(exceptionMap['statusMessage'], 'Not Found');
      expect(exceptionMap['errorMessage'], 'Resource not found');
    });

    test('fromMap() should create an APIException object from a map', () {
      final exceptionMap = {
        'statusCode': 500,
        'statusMessage': 'Internal Server Error',
        'errorMessage': 'Something went wrong',
      };

      final exception = APIException.fromMap(exceptionMap);

      expect(exception.statusCode, 500);
      expect(exception.statusMessage, 'Internal Server Error');
      expect(exception.errorMessage, 'Something went wrong');
    });

    test('toJson() should return a JSON representation of the APIException',
        () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final exceptionJson = exception.toJson();

      expect(exceptionJson,
          '{"statusCode":404,"statusMessage":"Not Found","errorMessage":"Resource not found"}');
    });

    test('fromJson() should create an APIException object from a JSON string',
        () {
      const exceptionJson =
          '{"statusCode":500,"statusMessage":"Internal Server Error","errorMessage":"Something went wrong"}';

      final exception = APIException.fromJson(exceptionJson);

      expect(exception.statusCode, 500);
      expect(exception.statusMessage, 'Internal Server Error');
      expect(exception.errorMessage, 'Something went wrong');
    });

    test('toString() should return a string representation of the APIException',
        () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final exceptionString = exception.toString();

      expect(exceptionString,
          'APIException(statusCode: 404, statusMessage: Not Found, errorMessage: Resource not found)');
    });

    test('equality check should work correctly for APIException objects', () {
      final exception1 = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final exception2 = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      expect(exception1, equals(exception2));
    });

    test('hashCode should be calculated correctly for APIException objects',
        () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      final expectedHashCode = exception.statusCode.hashCode ^
          exception.statusMessage.hashCode ^
          exception.errorMessage.hashCode;

      expect(exception.hashCode, expectedHashCode);
    });

    test('message should return the error message of the APIException', () {
      final exception = APIException(
        statusCode: 404,
        statusMessage: 'Not Found',
        errorMessage: 'Resource not found',
      );

      expect(exception.message, 'Resource not found');
    });
  });
}
