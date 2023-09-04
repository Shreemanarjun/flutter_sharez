// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:flutter_sharez/data/model/receiver_model.dart' as _i19;
import 'package:flutter_sharez/data/model/sender_model.dart' as _i20;
import 'package:flutter_sharez/features/confirm_connection/view/confirm_connection_page.dart'
    deferred as _i1;
import 'package:flutter_sharez/features/counter/view/counter_page.dart'
    deferred as _i2;
import 'package:flutter_sharez/features/device_share/view/device_share_page.dart'
    deferred as _i4;
import 'package:flutter_sharez/features/device_share/view/tabs/device_info_tab_page.dart'
    deferred as _i3;
import 'package:flutter_sharez/features/device_share/view/tabs/sender_files_tab_page.dart'
    deferred as _i15;
import 'package:flutter_sharez/features/downloads/view/downloads_page.dart'
    deferred as _i5;
import 'package:flutter_sharez/features/file_selector/view/file_selector_page.dart'
    deferred as _i6;
import 'package:flutter_sharez/features/help_dialog/view/help_dialog_page.dart'
    deferred as _i7;
import 'package:flutter_sharez/features/home/view/home_page.dart'
    deferred as _i8;
import 'package:flutter_sharez/features/manual_connect/view/manual_connect_page.dart'
    deferred as _i9;
import 'package:flutter_sharez/features/qr_scan/qr_scan_page.dart'
    deferred as _i10;
import 'package:flutter_sharez/features/receive/view/receive_page.dart'
    deferred as _i11;
import 'package:flutter_sharez/features/receive/view/receive_state_page.dart'
    deferred as _i12;
import 'package:flutter_sharez/features/send/view/send_page.dart'
    deferred as _i13;
import 'package:flutter_sharez/features/send/view/send_state_page.dart'
    deferred as _i14;
import 'package:flutter_sharez/features/settings/view/settings_page.dart'
    deferred as _i16;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    ConfirmConnectionDialogRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmConnectionDialogRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
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
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.CounterPage(),
        ),
      );
    },
    DeviceInfoTabRoute.name: (routeData) {
      final args = routeData.argsAs<DeviceInfoTabRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.DeviceInfoTabPage(
            key: args.key,
            senderModel: args.senderModel,
          ),
        ),
      );
    },
    DeviceShareRoute.name: (routeData) {
      final args = routeData.argsAs<DeviceShareRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.DeviceSharePage(
            key: args.key,
            senderModel: args.senderModel,
          ),
        ),
      );
    },
    DownloadsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.DownloadsPage(),
        ),
      );
    },
    FileSelectorRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.FileSelectorPage(),
        ),
      );
    },
    HelpDialogRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.HelpDialogPage(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.HomePage(),
        ),
      );
    },
    ManualConnectRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.ManualConnectPage(),
        ),
      );
    },
    QrScanRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.QrScanPage(),
        ),
      );
    },
    ReceiveRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.ReceivePage(),
        ),
      );
    },
    ReceiveStateRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.ReceiveStatePage(),
        ),
      );
    },
    SendRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.SendPage(),
        ),
      );
    },
    SendStateRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.SendStatePage(),
        ),
      );
    },
    SenderFilesTabRoute.name: (routeData) {
      final args = routeData.argsAs<SenderFilesTabRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i15.loadLibrary,
          () => _i15.SenderFilesTabPage(
            key: args.key,
            senderModel: args.senderModel,
          ),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.DeferredWidget(
          _i16.loadLibrary,
          () => _i16.SettingsPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ConfirmConnectionDialogPage]
class ConfirmConnectionDialogRoute
    extends _i17.PageRouteInfo<ConfirmConnectionDialogRouteArgs> {
  ConfirmConnectionDialogRoute({
    _i18.Key? key,
    required _i19.ReceiverModel receiverModel,
    required void Function(bool) onCofirmation,
    List<_i17.PageRouteInfo>? children,
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

  static const _i17.PageInfo<ConfirmConnectionDialogRouteArgs> page =
      _i17.PageInfo<ConfirmConnectionDialogRouteArgs>(name);
}

class ConfirmConnectionDialogRouteArgs {
  const ConfirmConnectionDialogRouteArgs({
    this.key,
    required this.receiverModel,
    required this.onCofirmation,
  });

  final _i18.Key? key;

  final _i19.ReceiverModel receiverModel;

  final void Function(bool) onCofirmation;

  @override
  String toString() {
    return 'ConfirmConnectionDialogRouteArgs{key: $key, receiverModel: $receiverModel, onCofirmation: $onCofirmation}';
  }
}

/// generated route for
/// [_i2.CounterPage]
class CounterRoute extends _i17.PageRouteInfo<void> {
  const CounterRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DeviceInfoTabPage]
class DeviceInfoTabRoute extends _i17.PageRouteInfo<DeviceInfoTabRouteArgs> {
  DeviceInfoTabRoute({
    _i18.Key? key,
    required _i20.SenderModel senderModel,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          DeviceInfoTabRoute.name,
          args: DeviceInfoTabRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DeviceInfoTabRoute';

  static const _i17.PageInfo<DeviceInfoTabRouteArgs> page =
      _i17.PageInfo<DeviceInfoTabRouteArgs>(name);
}

class DeviceInfoTabRouteArgs {
  const DeviceInfoTabRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i18.Key? key;

  final _i20.SenderModel senderModel;

  @override
  String toString() {
    return 'DeviceInfoTabRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i4.DeviceSharePage]
class DeviceShareRoute extends _i17.PageRouteInfo<DeviceShareRouteArgs> {
  DeviceShareRoute({
    _i18.Key? key,
    required _i20.SenderModel senderModel,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          DeviceShareRoute.name,
          args: DeviceShareRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DeviceShareRoute';

  static const _i17.PageInfo<DeviceShareRouteArgs> page =
      _i17.PageInfo<DeviceShareRouteArgs>(name);
}

class DeviceShareRouteArgs {
  const DeviceShareRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i18.Key? key;

  final _i20.SenderModel senderModel;

  @override
  String toString() {
    return 'DeviceShareRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i5.DownloadsPage]
class DownloadsRoute extends _i17.PageRouteInfo<void> {
  const DownloadsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DownloadsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.FileSelectorPage]
class FileSelectorRoute extends _i17.PageRouteInfo<void> {
  const FileSelectorRoute({List<_i17.PageRouteInfo>? children})
      : super(
          FileSelectorRoute.name,
          initialChildren: children,
        );

  static const String name = 'FileSelectorRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HelpDialogPage]
class HelpDialogRoute extends _i17.PageRouteInfo<void> {
  const HelpDialogRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HelpDialogRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpDialogRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ManualConnectPage]
class ManualConnectRoute extends _i17.PageRouteInfo<void> {
  const ManualConnectRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ManualConnectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManualConnectRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.QrScanPage]
class QrScanRoute extends _i17.PageRouteInfo<void> {
  const QrScanRoute({List<_i17.PageRouteInfo>? children})
      : super(
          QrScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScanRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ReceivePage]
class ReceiveRoute extends _i17.PageRouteInfo<void> {
  const ReceiveRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ReceiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ReceiveStatePage]
class ReceiveStateRoute extends _i17.PageRouteInfo<void> {
  const ReceiveStateRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ReceiveStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveStateRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SendPage]
class SendRoute extends _i17.PageRouteInfo<void> {
  const SendRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SendStatePage]
class SendStateRoute extends _i17.PageRouteInfo<void> {
  const SendStateRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SendStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendStateRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SenderFilesTabPage]
class SenderFilesTabRoute extends _i17.PageRouteInfo<SenderFilesTabRouteArgs> {
  SenderFilesTabRoute({
    _i18.Key? key,
    required _i20.SenderModel senderModel,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SenderFilesTabRoute.name,
          args: SenderFilesTabRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'SenderFilesTabRoute';

  static const _i17.PageInfo<SenderFilesTabRouteArgs> page =
      _i17.PageInfo<SenderFilesTabRouteArgs>(name);
}

class SenderFilesTabRouteArgs {
  const SenderFilesTabRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i18.Key? key;

  final _i20.SenderModel senderModel;

  @override
  String toString() {
    return 'SenderFilesTabRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i16.SettingsPage]
class SettingsRoute extends _i17.PageRouteInfo<void> {
  const SettingsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
