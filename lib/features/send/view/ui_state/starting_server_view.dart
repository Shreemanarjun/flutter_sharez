import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StartingServerView extends ConsumerWidget {
  const StartingServerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
               height: 48,
               width: 48,
               child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: theme.colorScheme.primary,
               ),
           ),
           const SizedBox(height: 24),
           Text(
             t.settingUpServer,
             style: theme.textTheme.large.copyWith(
               fontWeight: FontWeight.w600,
               color: theme.colorScheme.foreground,
             )
           ),
           const SizedBox(height: 8),
           Text(
             "Preparing secure local network...",
             style: theme.textTheme.muted,
           ),
          ],
        ),
      ),
    );
  }
}
