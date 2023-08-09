import 'dart:async';

import 'package:alfred/alfred.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/sender_service.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';

final senderServicePod = Provider.autoDispose<SenderService>((ref) {
  return SenderService(
    app: ref.watch(alfredPod),
    port: ref.watch(defaultPortProvider),
    sharedFIles: ref.watch(paltformFilesPod),
  );
});

final alfredPod = Provider.autoDispose<Alfred>((ref) {
  FutureOr missingHandler(HttpRequest req, HttpResponse res) {
    res.statusCode = 404;
    return {'message': '${req.uri.toString()} not found'};
  }

  FutureOr onInternalError(HttpRequest req, HttpResponse res) {
    res.statusCode = 500;
    return {'message': 'Error in ${req..uri.toString()},'};
  }

  return Alfred(
    onNotFound: missingHandler,
    onInternalError: onInternalError,
  );
});

final defaultPortProvider = StateProvider.autoDispose(
  (ref) => 8080,
);

final paltformFilesPod = Provider.autoDispose<List<PlatformFile>>((ref) {
  return ref.watch(
    selectedFilesPod.select(
      (value) => value.map((e) => e.file).toList(),
    ),
  );
});
