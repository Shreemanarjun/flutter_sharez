import 'package:dio/dio.dart';
import 'package:flutter_sharez/bootstrap.dart';

// coverage:ignore-file

///This interceptor to print form data content of the request body
class FormDataInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final data = options.data;

    if (data is FormData) {
      ///print form data
      for (final item in data.fields) {
        talker.log('${item.key} : ${item.value}');
      }
    }
    super.onRequest(options, handler);
  }
}
