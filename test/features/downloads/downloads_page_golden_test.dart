import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/data/model/download_item.dart';
import 'package:flutter_sharez/features/downloads/controller/download_history_pod.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spot/spot.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockDownloadHistoryNotifier extends DownloadHistoryNotifier {
  @override
  List<DownloadItem> build() {
    return [
      DownloadItem(
        name: 'Wedding_Video.mp4',
        size: 1024 * 1024 * 250,
        path: '/mock/downloads/1',
        downloadDate: DateTime(2024, 3, 22, 14, 30),
        isCompleted: true,
      ),
      DownloadItem(
        name: 'Project_Design.pdf',
        size: 1024 * 1024 * 5,
        path: '/mock/downloads/2',
        downloadDate: DateTime(2024, 3, 22, 10, 15),
        isCompleted: true,
      ),
      DownloadItem(
        name: 'Game_Setup.exe',
        size: 1024 * 1024 * 1400,
        path: '/mock/downloads/3',
        downloadDate: DateTime(2024, 3, 21, 22, 00),
        isCompleted: false,
      ),
    ];
  }
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  goldenTest(
    name: 'DownloadsPage Visuals',
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
          downloadHistoryPod.overrideWith(MockDownloadHistoryNotifier.new),
        ],
        child: ShadApp.router(
          routerConfig: router.config(
            deepLinkBuilder: (_) => const DeepLink([DownloadsRoute()]),
          ),
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
      tester.view.padding = FakeViewPadding.zero;
      tester.view.viewPadding = FakeViewPadding.zero;
      await tester.pump();
    },
  );
}
