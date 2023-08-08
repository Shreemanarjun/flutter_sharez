// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
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
import 'package:flutter_sharez/features/send/view/send_state_page.dart'
    deferred as _i7;
import 'package:flutter_sharez/features/settings/view/settings_page.dart'
    deferred as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CounterPage(),
        ),
      );
    },
    DownloadsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.DownloadsPage(),
        ),
      );
    },
    FileSelector.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.FileSelector(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.HomePage(),
        ),
      );
    },
    ReceiveRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.ReceivePage(),
        ),
      );
    },
    SendRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.SendPage(),
        ),
      );
    },
    SendStateRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.SendStatePage(),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.SettingsPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterPage]
class CounterRoute extends _i9.PageRouteInfo<void> {
  const CounterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DownloadsPage]
class DownloadsRoute extends _i9.PageRouteInfo<void> {
  const DownloadsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DownloadsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.FileSelector]
class FileSelector extends _i9.PageRouteInfo<void> {
  const FileSelector({List<_i9.PageRouteInfo>? children})
      : super(
          FileSelector.name,
          initialChildren: children,
        );

  static const String name = 'FileSelector';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ReceivePage]
class ReceiveRoute extends _i9.PageRouteInfo<void> {
  const ReceiveRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ReceiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SendPage]
class SendRoute extends _i9.PageRouteInfo<void> {
  const SendRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SendStatePage]
class SendStateRoute extends _i9.PageRouteInfo<void> {
  const SendStateRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SendStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendStateRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingsPage]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
