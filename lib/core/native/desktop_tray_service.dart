import 'dart:io';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DesktopTrayService with TrayListener, WindowListener {
  static final DesktopTrayService _instance = DesktopTrayService._internal();
  factory DesktopTrayService() => _instance;
  DesktopTrayService._internal();

  Future<void> init() async {
    if (Platform.isAndroid || Platform.isIOS) return;

    await windowManager.ensureInitialized();
    windowManager.addListener(this);

    await trayManager.setIcon(
      Platform.isWindows
          ? 'assets/images/logo/ic_launcher_adaptive_fore.png'
          : 'assets/images/logo/ic_launcher_adaptive_fore.png',
    );
    
    final Menu menu = Menu(
      items: [
        MenuItem(
          key: 'show_window',
          label: 'Show Portal',
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
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_window') {
      windowManager.show();
      windowManager.focus();
    } else if (menuItem.key == 'exit_app') {
      exit(0);
    }
  }

  @override
  void onWindowMinimize() {
    windowManager.hide();
  }
}
