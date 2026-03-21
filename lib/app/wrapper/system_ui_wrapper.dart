import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiWrapper extends StatelessWidget {
  const SystemUiWrapper(
      {super.key, required this.child, required this.currentTheme});
  final Widget child;
  final ThemeMode currentTheme;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _getSystemUiOverlayStyle(currentTheme),
      child: child,
    );
  }

  SystemUiOverlayStyle _getSystemUiOverlayStyle(ThemeMode theme) {
    if (theme == ThemeMode.dark) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withValues(alpha: 0.4),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    } else {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white.withValues(alpha: 0.4),
        systemNavigationBarColor: Colors.grey,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    }
  }
}
