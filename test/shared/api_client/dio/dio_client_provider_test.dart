import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/shared/api_client/dio/default_api_interceptor.dart';
import 'package:flutter_sharez/shared/api_client/dio/default_time_response_interceptor.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/api_client/dio/form_data_interceptor.dart';
import 'package:riverpod_test/riverpod_test.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

void main() {
  testProvider(
    'expect dio.baseUrl should be "https://randomuser.me/api/"',
    provider: dioProvider,
    expect: () => [
      isA<DioForNative>()
          .having(
            (d) => d.options.baseUrl,
            'default interceptor should be 2',
            equals("https://randomuser.me/api/"),
          )
          .having(
            (d) => d.interceptors.length,
            "Interceptors should be 5",
            equals(5),
          )
          .having(
              (d) => d.interceptors,
              "Contains a time response interceptor",
              containsAll(
                [
                  isA<TimeResponseInterceptor>(),
                  isA<FormDataInterceptor>(),
                  isA<TalkerDioLogger>(),
                  isA<DefaultAPIInterceptor>(),
                ],
              )),
    ],
  );
}
