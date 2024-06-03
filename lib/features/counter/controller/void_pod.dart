import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/item_data/controller/item_data_pod.dart';

final voidPod = FutureProvider.autoDispose<void>((ref) async {
  ref.watch(itemDataPod(0));

  return;
});
