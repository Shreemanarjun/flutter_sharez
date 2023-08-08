import 'package:dio/dio.dart';
import 'package:flutter_sharez/shared/api_client/dio/default_api_error_handler.dart';

// coverage:ignore-file

///This one is default interceptor which includes default api
///error handler
class DefaultAPIInterceptor extends Interceptor {
  DefaultAPIInterceptor({
    required this.dio,
  });
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    defaultAPIErrorHandler(err, handler, dio);
  }
}
