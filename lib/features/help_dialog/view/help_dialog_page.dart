import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class HelpDialogPage extends ConsumerWidget {
  const HelpDialogPage({super.key});

  void launchGithubissue() async {
    final uri =
        Uri.parse('https://github.com/Shreemanarjun/flutter_sharez/issues');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return AlertDialog(
      title: t.reportABug.text.xl.isIntrinsic.makeCentered(),
      content: t.reportDescription.text.bold.lg.center.isIntrinsic.make(),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.tertiary,
            foregroundColor: context.colors.surface,
          ),
          onPressed: () {
            context.back();
          },
          child: t.cancel.text.isIntrinsic.make(),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.surface,
          ),
          onPressed: launchGithubissue,
          child: t.report.text.isIntrinsic.make(),
        ),
      ],
    );
  }
}
