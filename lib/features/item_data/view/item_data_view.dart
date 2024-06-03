import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/item_data/controller/item_data_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDataView extends StatelessWidget {
  final int data;
  const ItemDataView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final dataAsync = ref.watch(itemDataPod(data));
        return dataAsync.easyWhen(
          data: (data) {
            return "$data".text.xl4.make().onTap(() {
              ref.invalidate(itemDataPod(data));
            });
          },
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
        );
      },
    );
  }
}
