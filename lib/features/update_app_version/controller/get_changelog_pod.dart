import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cache_extensions.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cancel_extensions.dart';

final getChangeLogPod = FutureProvider.autoDispose<String>(
  (ref) async {
    final dio = ref.watch(dioProvider(
        "https://raw.githubusercontent.com/Shreemanarjun/flutter_sharez/main"));
    final result = await dio.get(
      '/CHANGELOG.md',
      cancelToken: ref.cancelToken(),
    );
    if (result.statusCode == 200) {
      ref.cacheFor(const Duration(seconds: 10));
      return result.data.toString();
    } else {
      throw "Error getting changelog";
    }
  },
  name: 'getChangeLogPod',
);
