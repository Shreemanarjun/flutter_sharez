import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/features/settings/controller/current_version_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({Key? key}) : super(key: key);

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
            .safeArea();
      },
    );
  }
}

class AboutTile extends StatelessWidget {
  final String? version;
  const AboutTile({super.key, this.version});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ImageIcon(
        AssetImage("assets/images/logo/ic_launcher_adaptive_fore.png"),
        size: 100,
      ),
      title: "Fshare ".text.xl.bold.make(),
      subtitle: "$version".text.lg.semiBold.make(),
      trailing: <Widget>[
        IconButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationVersion: version,
              applicationLegalese:
                  "Developed By Shreeman Arjun \nMade with 💙 Riverpod ",
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
      ].hStack(axisSize: MainAxisSize.min),
      iconColor: Colors.blue,
    );
  }
}
