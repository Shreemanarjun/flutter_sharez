import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/update_model.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cache_extensions.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cancel_extensions.dart';

final getUpdateModelPod = FutureProvider.autoDispose<UpdateModel>(
  (ref) async {
    final dio = ref.watch(dioProvider(
        "https://api.github.com/repos/Shreemanarjun/flutter_sharez"));
    final result = await dio.get(
      '/releases/latest',
      cancelToken: ref.cancelToken(),
    );
    final updatemodel = UpdateModel.fromMap(result.data);
    ref.cacheFor(const Duration(seconds: 10));
    return updatemodel;
  },
  name: 'getUpdateModelPod',
);
