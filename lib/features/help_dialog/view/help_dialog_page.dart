import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:url_launcher/url_launcher.dart';

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
      title: Center(
        child: Text(
          t.reportABug,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      content: Text(
        t.reportDescription,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(t.cancel),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: launchGithubissue,
          child: Text(t.report),
        ),
      ],
    );
  }
}
