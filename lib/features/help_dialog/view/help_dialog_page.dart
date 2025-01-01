import 'package:auto_route/auto_route.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class HelpDialogPage extends StatelessWidget {
  const HelpDialogPage({super.key});

  void launchGithubissue() async {
    final uri =
        Uri.parse('https://github.com/Shreemanarjun/flutter_sharez/issues');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: context.t.reportABug.text.xl.isIntrinsic.makeCentered(),
      content:
          context.t.reportDescription.text.bold.lg.center.isIntrinsic.make(),
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
          child: context.t.cancel.text.isIntrinsic.make(),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.surface,
          ),
          onPressed: launchGithubissue,
          child: context.t.report.text.isIntrinsic.make(),
        ),
      ],
    );
  }
}
