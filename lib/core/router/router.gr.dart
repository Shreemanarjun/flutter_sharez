// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter_sharez/data/model/receiver_model.dart' as _i14;
import 'package:flutter_sharez/features/confirm_connection/view/confirm_connection_page.dart'
    deferred as _i1;
import 'package:flutter_sharez/features/counter/view/counter_page.dart'
    deferred as _i2;
import 'package:flutter_sharez/features/downloads/view/downloads_page.dart'
    deferred as _i3;
import 'package:flutter_sharez/features/file_selector/view/file_selector_page.dart'
    deferred as _i4;
import 'package:flutter_sharez/features/home/view/home_page.dart'
    deferred as _i5;
import 'package:flutter_sharez/features/qr_scan/qr_scan_page.dart'
    deferred as _i6;
import 'package:flutter_sharez/features/receive/view/receive_page.dart'
    deferred as _i7;
import 'package:flutter_sharez/features/receive/view/receive_state_page.dart'
    deferred as _i8;
import 'package:flutter_sharez/features/send/view/send_page.dart'
    deferred as _i9;
import 'package:flutter_sharez/features/send/view/send_state_page.dart'
    deferred as _i10;
import 'package:flutter_sharez/features/settings/view/settings_page.dart'
    deferred as _i11;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    ConfirmConnectionDialogRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmConnectionDialogRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.ConfirmConnectionDialogPage(
            key: args.key,
            receiverModel: args.receiverModel,
            onCofirmation: args.onCofirmation,
          ),
        ),
      );
    },
    CounterRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.CounterPage(),
        ),
      );
    },
    DownloadsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.DownloadsPage(),
        ),
      );
    },
    FileSelectorRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.FileSelectorPage(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.HomePage(),
        ),
      );
    },
    QrScanRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.QrScanPage(),
        ),
      );
    },
    ReceiveRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.ReceivePage(),
        ),
      );
    },
    ReceiveStateRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.ReceiveStatePage(),
        ),
      );
    },
    SendRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.SendPage(),
        ),
      );
    },
    SendStateRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.SendStatePage(),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.SettingsPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ConfirmConnectionDialogPage]
class ConfirmConnectionDialogRoute
    extends _i12.PageRouteInfo<ConfirmConnectionDialogRouteArgs> {
  ConfirmConnectionDialogRoute({
    _i13.Key? key,
    required _i14.ReceiverModel receiverModel,
    required void Function(bool) onCofirmation,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ConfirmConnectionDialogRoute.name,
          args: ConfirmConnectionDialogRouteArgs(
            key: key,
            receiverModel: receiverModel,
            onCofirmation: onCofirmation,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmConnectionDialogRoute';

  static const _i12.PageInfo<ConfirmConnectionDialogRouteArgs> page =
      _i12.PageInfo<ConfirmConnectionDialogRouteArgs>(name);
}

class ConfirmConnectionDialogRouteArgs {
  const ConfirmConnectionDialogRouteArgs({
    this.key,
    required this.receiverModel,
    required this.onCofirmation,
  });

  final _i13.Key? key;

  final _i14.ReceiverModel receiverModel;

  final void Function(bool) onCofirmation;

  @override
  String toString() {
    return 'ConfirmConnectionDialogRouteArgs{key: $key, receiverModel: $receiverModel, onCofirmation: $onCofirmation}';
  }
}

/// generated route for
/// [_i2.CounterPage]
class CounterRoute extends _i12.PageRouteInfo<void> {
  const CounterRoute({List<_i12.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DownloadsPage]
class DownloadsRoute extends _i12.PageRouteInfo<void> {
  const DownloadsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DownloadsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FileSelectorPage]
class FileSelectorRoute extends _i12.PageRouteInfo<void> {
  const FileSelectorRoute({List<_i12.PageRouteInfo>? children})
      : super(
          FileSelectorRoute.name,
          initialChildren: children,
        );

  static const String name = 'FileSelectorRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.QrScanPage]
class QrScanRoute extends _i12.PageRouteInfo<void> {
  const QrScanRoute({List<_i12.PageRouteInfo>? children})
      : super(
          QrScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScanRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ReceivePage]
class ReceiveRoute extends _i12.PageRouteInfo<void> {
  const ReceiveRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ReceiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ReceiveStatePage]
class ReceiveStateRoute extends _i12.PageRouteInfo<void> {
  const ReceiveStateRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ReceiveStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveStateRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SendPage]
class SendRoute extends _i12.PageRouteInfo<void> {
  const SendRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SendStatePage]
class SendStateRoute extends _i12.PageRouteInfo<void> {
  const SendStateRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SendStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendStateRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SettingsPage]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
