import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/app/app.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_info/platform_info.dart';

/// This entry point should be used for production only
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //You can override your environment variable in bootstrap method here for providers
  final path = await Platform.I.when(
        android: () async {
          return (await getApplicationDocumentsDirectory()).path;
        },
        orElse: () async => (await getDownloadsDirectory())?.path,
      ) ??
      "/";

  // device preview enable
  bootstrap(
    () => DevicePreview(
      enabled: !kReleaseMode,
      tools: [
        ...DevicePreview.defaultTools,
        DevicePreviewScreenshot(
            onScreenshot: screenshotAsFiles(Directory(path))),
      ],
      builder: (context) => const App(),
    ),
  );
}
