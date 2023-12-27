import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_version.dart';
import 'package:flutter_sharez/features/update_app_version/view/widgets/animated_sync.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';

class UpdateAppVersionIcon extends ConsumerWidget {
  const UpdateAppVersionIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateCheckAsync = ref.watch(checkUpdateAvailablePod);
    return updateCheckAsync.easyWhen(
        data: (updatemodel) {
          return IconButton(
            onPressed: () async {
              ref.invalidate(getUpdateModelPod);
              final data = await ref.read(checkUpdateAvailablePod.future);
              ref
                  .read(autorouterProvider)
                  .navigate(ChangelogRoute(updateModel: data));
            },
            icon: Icon(
              Icons.sync,
              color: updatemodel != null ? Colors.green : null,
            ),
          );
        },
        errorWidget: (error, stackTrace) => IconButton(
            onPressed: () async {
              ref.invalidate(getUpdateModelPod);
              final data = await ref.read(checkUpdateAvailablePod.future);
              ref
                  .read(autorouterProvider)
                  .navigate(ChangelogRoute(updateModel: data));
            },
            icon: const Icon(
              Icons.sync,
              color: Colors.red,
            )),
        loadingWidget: () => const SpinningIconButton(
              iconData: Icons.sync,
            ),
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false);
  }
}
