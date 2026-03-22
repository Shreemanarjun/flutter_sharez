import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/app/wrapper/app_gesture_detector.dart';
import 'package:flutter_sharez/app/wrapper/media_query_wrapper.dart';
import 'package:flutter_sharez/app/wrapper/responsive_wrapper.dart';
import 'package:flutter_sharez/app/wrapper/system_ui_wrapper.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/shared/helper/talker_error_handler.dart';
import 'package:flutter_sharez/shared/widget/no_internet_widget.dart';
import 'package:flutter_sharez/shared/widget/shortcuts_wrapper.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper(
      {super.key, required this.child, required this.currentTheme});
  final Widget child;
  final ThemeMode currentTheme;

  @override
  Widget build(BuildContext context) {
    return Toast(
      navigatorKey: navigatorKey,
      child: AppGestureDetector(
        child: TalkerErrorHandler(
          child: ShortcutsWrapper(
            child: ResponsiveWrapper(
              child: MediaQueryWrapper(
                child: SystemUiWrapper(
                  currentTheme: currentTheme,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    ).monitorConnection();
  }
}
