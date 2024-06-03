import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:platform_info/platform_info.dart';

///This function is used for setting up default orientation,
///display refresh rate, hide keyboard etc system services.
Future<void> init() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [
      SystemUiOverlay.top,
    ],
  );
  await platform.when(
    android: FlutterDisplayMode.setHighRefreshRate,
  );
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
}
