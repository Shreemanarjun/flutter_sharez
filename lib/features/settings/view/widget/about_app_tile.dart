import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/features/settings/controller/current_version_pod.dart';
import 'package:flutter_sharez/features/update_app_version/view/update_app_version_icon.dart';

import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentversionAsync = ref.watch(currentVersionPod);
        return currentversionAsync
            .easyWhen(
              data: (version) => AboutTile(
                version: version,
              ),
              errorWidget: (error, stackTrace) => const AboutTile(),
              skipError: true,
              isLinear: true,
            )
            .pOnly(bottom: 16);
      },
    );
  }
}

class AboutTile extends ConsumerWidget {
  final String? version;
  const AboutTile({super.key, this.version});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return ListTile(
      leading: const ImageIcon(
        AssetImage("assets/images/logo/ic_launcher_adaptive_fore.png"),
        size: 100,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: t.app_title.text.lg.bold.make(),
      subtitle: "$version".text.lg.semiBold.make(),
      trailing: <Widget>[
        IconButton(
          onPressed: () {
            showAboutDialog(
              applicationName: t.app_title,
              context: context,
              applicationVersion: version,
              applicationLegalese: t.developed_by,
              applicationIcon: const ImageIcon(
                AssetImage("assets/images/logo/ic_launcher_adaptive_fore.png"),
                size: 60,
              ),
            );
          },
          icon: const Icon(Icons.info),
        ),
        Consumer(
          builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                ref.read(autorouterProvider).navigate(
                      const HelpDialogRoute(),
                      onFailure: (failure) => talker.error(failure),
                    );
              },
              icon: const Icon(
                Icons.bug_report_sharp,
              ),
            );
          },
        ),
        const UpdateAppVersionIcon()
      ].hStack(
        axisSize: MainAxisSize.min,
      ),
      iconColor: Colors.blue,
    );
  }
}
