// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_info/platform_info.dart';
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
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: !Platform.I.isIOS,
    ),
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

  runApp(
    UncontrolledProviderScope(
      container: parent,
      child: await builder(),
    ),
  );
}
