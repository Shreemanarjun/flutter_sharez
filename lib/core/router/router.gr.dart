// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter_sharez/features/counter/view/counter_page.dart'
    deferred as _i1;
import 'package:flutter_sharez/features/downloads/view/downloads_page.dart'
    deferred as _i2;
import 'package:flutter_sharez/features/file_selector/view/file_selector_page.dart'
    deferred as _i3;
import 'package:flutter_sharez/features/home/view/home_page.dart'
    deferred as _i4;
import 'package:flutter_sharez/features/receive/view/receive_page.dart'
    deferred as _i5;
import 'package:flutter_sharez/features/send/view/send_page.dart'
    deferred as _i6;
import 'package:flutter_sharez/features/settings/view/settings_page.dart'
    deferred as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CounterPage(),
        ),
      );
    },
    DownloadsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.DownloadsPage(),
        ),
      );
    },
    FileSelector.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.FileSelector(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.HomePage(),
        ),
      );
    },
    ReceiveRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.ReceivePage(),
        ),
      );
    },
    SendRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.SendPage(),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.SettingsPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterPage]
class CounterRoute extends _i8.PageRouteInfo<void> {
  const CounterRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DownloadsPage]
class DownloadsRoute extends _i8.PageRouteInfo<void> {
  const DownloadsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          DownloadsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.FileSelector]
class FileSelector extends _i8.PageRouteInfo<void> {
  const FileSelector({List<_i8.PageRouteInfo>? children})
      : super(
          FileSelector.name,
          initialChildren: children,
        );

  static const String name = 'FileSelector';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ReceivePage]
class ReceiveRoute extends _i8.PageRouteInfo<void> {
  const ReceiveRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ReceiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SendPage]
class SendRoute extends _i8.PageRouteInfo<void> {
  const SendRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
