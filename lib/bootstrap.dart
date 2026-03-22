// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/native/desktop_tray_service.dart';
import 'package:flutter_sharez/features/file_selector/controller/sharing_intent_pod.dart';
import 'package:flutter_sharez/data/service/receive/push_receiver_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

// coverage:ignore-file

/// This `talker` global variable used for logging and accessible
///  to other classed or function
// coverage:ignore-file

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    // maxHistoryItems: null,
    useConsoleLogs: !kReleaseMode,
    enabled: !kReleaseMode,
  ),
);

///This bootstrap function builds widget asynchronusly
///where builder function used for building your start widget.
///You can override riverpod providers ,also setup observers
///or you can put a provider container in parent
Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required ProviderContainer parent,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // 🚀 OPTIMIZATION: Fire-and-forget non-critical native initializations
  // This prevents blocking the UI transition from Splash to Home.
  unawaited(_initNativeServices(parent));

  runApp(
    UncontrolledProviderScope(
      container: parent,
      child: await builder(),
    ),
  );
}

Future<void> _initNativeServices(ProviderContainer parent) async {
  try {
    if (!kIsWeb) {
      parent.read(sharingIntentProvider);
      parent.read(pushReceiverProvider);
      await DesktopTrayService().init(parent);
    }
  } catch (e, st) {
    talker.error("Failed to initialize native services: $e", e, st);
  }
}
