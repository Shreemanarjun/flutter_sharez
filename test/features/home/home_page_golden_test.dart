import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/model/file_select_model.dart';
import 'package:flutter_sharez/features/file_selector/controller/notifier/selected_files_notifier.dart';
import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/data/service/sender/transfer_progress_pod.dart';
import 'package:flutter_sharez/features/send/controller/receiver_discovery_pod.dart';
import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';
import 'package:flutter_sharez/features/send/controller/notifier/send_state_notifier.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spot/spot.dart';
import 'package:flutter_sharez/core/is_golden_test_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockAppStorage extends Mock implements AppStorage {
  @override
  bool? getBool({required String key}) => false;
  @override
  String? get({required String key}) => '';
}

class PrefilledSendStateNotifier extends SendStateNotifier {
  @override
  FutureOr<SendState> build() => StartedServer(
        serverInfo: ServerInfo(
          ip: '192.168.1.10',
          allIps: ['192.168.1.10'],
          port: 8080,
          host: 'Sharez-Host',
          deviceName: 'MacBook Pro',
          deviceUUID: 'mock-uuid',
          os: 'macOS',
          version: '15.0',
        ),
      );
}

class PrefilledSelectedFilesNotifier extends FilesListNotifier {
  @override
  List<FileSelectModel> build() => [
        FileSelectModel(
          isSelected: false,
          file: PlatformFile(name: 'Vacation_Photo.jpg', size: 1024 * 1024 * 2, path: '/dummy/1'),
        ),
        FileSelectModel(
          isSelected: false,
          file: PlatformFile(name: 'Project_Design.pdf', size: 1024 * 1024 * 5, path: '/dummy/2'),
        ),
        FileSelectModel(
          isSelected: false,
          file: PlatformFile(name: 'App_Release.apk', size: 1024 * 1024 * 45, path: '/dummy/3'),
        ),
      ];
}

class MockReceiverDiscoveryNotifier extends ReceiverDiscoveryNotifier {
  @override
  AsyncValue<List<ReceiverModel>> build() {
    return AsyncData([
      ReceiverModel(
        ip: '192.168.1.15',
        port: 8080,
        host: 'Pixel-8-Pro',
        os: 'Android',
        version: '14',
        deviceUUID: 'uuid-pixel',
      ),
      ReceiverModel(
        ip: '192.168.1.22',
        port: 8080,
        host: 'iPad-Air',
        os: 'iOS',
        version: '17.4',
        deviceUUID: 'uuid-ipad',
      ),
    ]);
  }
}

class MockUploadProgressNotifier extends UploadProgressNotifier {
  @override
  Map<String, TransferInfo> build() {
    return {
      'Project_Design.pdf': TransferInfo(
        fileName: 'Project_Design.pdf',
        totalSize: 1024 * 1024 * 5,
        sentBytes: (1024 * 1024 * 3.2).toInt(),
        speed: 12 * 1024 * 1024,
        lastUpdate: DateTime.now(),
      ),
    };
  }
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  goldenTest(
    name: 'HomePage Module Visuals',
    supportedDevices: [
      const Device( // Phone
        name: 'phone',
        width: 393,
        height: 852,
        devicePixelRatio: 3,
        insets: EdgeInsets.zero,
      ),
      const Device( // Tablet
        name: 'tablet',
        width: 1024,
        height: 1366,
        devicePixelRatio: 2,
        insets: EdgeInsets.zero,
      ),
      const Device( // Desktop
        name: 'desktop',
        width: 1440,
        height: 900,
        insets: EdgeInsets.zero,
      ),
    ],
    builder: (_) {
      final t = AppLocale.en.buildSync();
      final router = AppRouter();

      return ProviderScope(
        overrides: [
          autorouterProvider.overrideWithValue(router),
          translationsPod.overrideWith((ref) => t),
          sendStateNotifierPod.overrideWith(() => PrefilledSendStateNotifier()),
          selectedFilesPod.overrideWith(() => PrefilledSelectedFilesNotifier()),
          checkUpdateAvailablePod.overrideWithValue(const AsyncData(null)),
          appStorageProvider.overrideWithValue(MockAppStorage()),
          isGoldenTestProvider.overrideWithValue(true),
          receiverDiscoveryProvider.overrideWith(MockReceiverDiscoveryNotifier.new),
          uploadProgressPod.overrideWith(MockUploadProgressNotifier.new),
        ],
        child: ShadApp.router(
          routerConfig: router.config(),
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
            ],
          ),
        ),
      );
    },
    action: (tester) async {
      // Force zero padding right before the screenshot to kill the blue strip
      tester.view.padding = FakeViewPadding.zero;
      tester.view.viewPadding = FakeViewPadding.zero;
      await tester.pump();
    },
  );
}
