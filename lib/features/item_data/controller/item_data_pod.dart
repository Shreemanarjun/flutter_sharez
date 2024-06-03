import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

final itemDataPod =
    FutureProvider.autoDispose.family<int, int>((ref, input) async {
  await Future.delayed(3.seconds);
  ref.keepAlive();
  return input;
});
