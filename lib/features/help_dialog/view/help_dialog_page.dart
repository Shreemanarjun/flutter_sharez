import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class HelpDialogPage extends StatelessWidget {
  const HelpDialogPage({Key? key}) : super(key: key);

  void launchGithubissue() async {
    final uri =
        Uri.parse('https://github.com/Shreemanarjun/flutter_sharez/issues');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: context.l10n.reportABug.text.xl.isIntrinsic.makeCentered(),
      content: l10n.reportDescription.text.bold.lg.center.isIntrinsic.make(),
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
          child: l10n.cancel.text.isIntrinsic.make(),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.surface,
          ),
          onPressed: launchGithubissue,
          child: l10n.report.text.isIntrinsic.make(),
        ),
      ],
    );
  }
}
