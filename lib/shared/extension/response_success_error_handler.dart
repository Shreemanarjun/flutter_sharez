import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

typedef Mapper<T> = T Function(dynamic data);

extension ResponseHandler on Response {
  Result<T, APIException> successErrorHandler<T>({
    required Mapper<T> successMapper,
    Mapper<APIException>? errorMapper,
    List<int> defaultSuccessCode = const [200],
  }) {
    if (defaultSuccessCode.contains(statusCode)) {
      if (kDebugMode) {
        T successData = successMapper(data);
        return Result<T, APIException>.success(successData);
      } else {
        try {
          T successData = successMapper(data);
          return Result<T, APIException>.success(successData);
        } catch (e) {
          APIException errorData = errorMapper?.call(data) ??
              APIException(
                statusCode: statusCode,
                errorMessage: 'Error parsing response data $e',
              );
          return Result<T, APIException>.error(errorData);
        }
      }
    } else {
      late APIException errorData;
      if (errorMapper != null) {
        errorData = errorMapper(data);
      } else {
        try {
          errorData = APIException.fromMap(data);
        } catch (e) {
          errorData = APIException(
            statusCode: statusCode,
            statusMessage: statusMessage,
            errorMessage: "Failed to get data $data",
          );
        }
      }

      return Result<T, APIException>.error(errorData);
    }
  }
}
