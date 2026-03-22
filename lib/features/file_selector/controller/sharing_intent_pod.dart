import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:flutter_sharez/bootstrap.dart';

final sharingIntentProvider = Provider<SharingIntentService>((ref) {
  final service = SharingIntentService(ref);
  service.init();
  return service;
});

class SharingIntentService {
  final Ref _ref;
  StreamSubscription? _intentDataStreamSubscription;

  SharingIntentService(this._ref);

  void init() {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      _handleAddSharedFiles(value);
    }, onError: (err) {
      talker.error("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      _handleAddSharedFiles(value);
      ReceiveSharingIntent.instance.reset();
    });
  }

  void _handleAddSharedFiles(List<SharedMediaFile> sharedFiles) {
    if (sharedFiles.isEmpty) return;
    
    talker.info("Received ${sharedFiles.length} shared files from system");
    for (final sharedFile in sharedFiles) {
      final platformFile = PlatformFile(
        path: sharedFile.path,
        name: sharedFile.path.split('/').last,
        size: 0, // We could use File(sharedFile.path).lengthSync() but async is safer
      );
      _ref.read(selectedFilesPod.notifier).addFile(platformFile);
    }
  }

  void dispose() {
    _intentDataStreamSubscription?.cancel();
  }
}
