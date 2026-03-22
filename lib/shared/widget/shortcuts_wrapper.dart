import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';

class ShortcutsWrapper extends ConsumerWidget {
  final Widget child;
  const ShortcutsWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(autorouterProvider);

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyS):
            const _NavigationIntent('send'),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
            const _NavigationIntent('send'),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyR):
            const _NavigationIntent('receive'),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyR):
            const _NavigationIntent('receive'),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyD):
            const _NavigationIntent('download'),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD):
            const _NavigationIntent('download'),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.comma):
            const _NavigationIntent('settings'),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.comma):
            const _NavigationIntent('settings'),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _NavigationIntent: CallbackAction<_NavigationIntent>(
            onInvoke: (intent) {
              switch (intent.route) {
                case 'send':
                  router.navigate(const HomeRoute());
                  break;
                case 'receive':
                  router.navigate(const ReceiveRoute());
                  break;
                case 'download':
                  router.navigate(const DownloadsRoute());
                  break;
                case 'settings':
                  router.navigate(const SettingsRoute());
                  break;
              }
              return null;
            },
          ),
        },
        child: child,
      ),
    );
  }
}

class _NavigationIntent extends Intent {
  final String route;
  const _NavigationIntent(this.route);
}
