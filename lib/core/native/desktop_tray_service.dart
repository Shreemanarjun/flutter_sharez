import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DesktopTrayService with TrayListener, WindowListener {
  static final DesktopTrayService _instance = DesktopTrayService._internal();
  factory DesktopTrayService() => _instance;
  DesktopTrayService._internal();

  ProviderContainer? _container;
  Future<void> init(ProviderContainer container) async {
    _container = container;
    if (Platform.isAndroid || Platform.isIOS) return;

    await windowManager.ensureInitialized();
    windowManager.addListener(this);
    // 🛑 Prevent immediate close to allow for graceful shutdown
    await windowManager.setPreventClose(true);

    await trayManager.setIcon(
      Platform.isWindows
          ? 'assets/images/logo/ic_launcher_adaptive_fore.png'
          : 'assets/images/logo/ic_launcher_adaptive_fore.png',
    );
    
    final Menu menu = Menu(
      items: [
        MenuItem(
          key: 'send',
          label: 'Send Files',
        ),
        MenuItem(
          key: 'receive',
          label: 'Receive Files',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'downloads',
          label: 'Download History',
        ),
        MenuItem(
          key: 'settings',
          label: 'Settings',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: 'Close Sharez',
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
    trayManager.addListener(this);
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.show();
    windowManager.focus();
  }

  @override
  Future<void> onWindowClose() async {
    // 🛑 Graceful Shutdown for Desktop
    final sender = _container?.read(senderServicePod);
    await sender?.stopServer();
    exit(0);
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'exit_app') {
      onWindowClose();
    } else {
      windowManager.show();
      windowManager.focus();
      final router = _container?.read(autorouterProvider);
      if (router != null) {
        switch (menuItem.key) {
          case 'send':
            router.navigate(const HomeRoute());
            break;
          case 'receive':
            router.navigate(const HomeRoute());
            break;
          case 'downloads':
            router.navigate(const DownloadsRoute());
            break;
          case 'settings':
            router.navigate(const SettingsRoute());
            break;
        }
      }
    }
  }

  @override
  void onWindowMinimize() {
    windowManager.hide();
  }
}
