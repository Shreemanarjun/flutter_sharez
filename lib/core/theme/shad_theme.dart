import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppShadTheme {
  static ShadThemeData light() {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: ShadBlueColorScheme.light(),
    );
  }

  static ShadThemeData dark() {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: ShadBlueColorScheme.dark(),
    );
  }
}
