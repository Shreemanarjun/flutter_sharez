import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spot/spot.dart';
import 'package:flutter_sharez/core/is_golden_test_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockReceiverServerListNotifier extends ReceiverServerListNotifier {
  @override
  Stream<List<SenderModel>> build() async* {
    yield [
      SenderModel(
        ip: '192.168.1.10',
        port: 8080,
        filesCount: 12,
        host: 'Pixel-8-Pro',
        deviceName: 'Pixel 8 Pro',
        deviceUUID: 'uuid-1',
        os: 'Android',
        version: '14',
      ),
      SenderModel(
        ip: '192.168.1.11',
        port: 8080,
        filesCount: 5,
        host: 'Anuj-iPhone',
        deviceName: 'iPhone 15 Pro',
        deviceUUID: 'uuid-2',
        os: 'iOS',
        version: '17.4',
      ),
    ];
  }
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  goldenTest(
    name: 'ReceivePage Visuals',
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
          checkUpdateAvailablePod.overrideWithValue(const AsyncData(null)),
          isGoldenTestProvider.overrideWithValue(true),
          oKServersListProvider.overrideWith(MockReceiverServerListNotifier.new),
        ],
        child: ShadApp.router(
          routerConfig: router.config(
            deepLinkBuilder: (_) => const DeepLink([ReceiveRoute()]),
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
