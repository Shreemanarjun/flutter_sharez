// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:flutter_sharez/data/model/receiver_model.dart' as _i22;
import 'package:flutter_sharez/data/model/sender_model.dart' as _i23;
import 'package:flutter_sharez/data/model/update_model.dart' as _i21;
import 'package:flutter_sharez/features/confirm_connection/view/confirm_connection_page.dart'
    deferred as _i2;
import 'package:flutter_sharez/features/counter/view/counter_page.dart'
    deferred as _i3;
import 'package:flutter_sharez/features/device_share/view/device_share_page.dart'
    deferred as _i5;
import 'package:flutter_sharez/features/device_share/view/tabs/device_info_tab_page.dart'
    deferred as _i4;
import 'package:flutter_sharez/features/device_share/view/tabs/sender_files_tab_page.dart'
    deferred as _i16;
import 'package:flutter_sharez/features/downloads/view/downloads_page.dart'
    deferred as _i6;
import 'package:flutter_sharez/features/file_selector/view/file_selector_page.dart'
    deferred as _i7;
import 'package:flutter_sharez/features/help_dialog/view/help_dialog_page.dart'
    deferred as _i8;
import 'package:flutter_sharez/features/home/view/home_page.dart'
    deferred as _i9;
import 'package:flutter_sharez/features/manual_connect/view/manual_connect_page.dart'
    deferred as _i10;
import 'package:flutter_sharez/features/qr_scan/qr_scan_page.dart'
    deferred as _i11;
import 'package:flutter_sharez/features/receive/view/receive_page.dart'
    deferred as _i12;
import 'package:flutter_sharez/features/receive/view/receive_state_page.dart'
    deferred as _i13;
import 'package:flutter_sharez/features/send/view/send_page.dart'
    deferred as _i14;
import 'package:flutter_sharez/features/send/view/send_state_page.dart'
    deferred as _i15;
import 'package:flutter_sharez/features/send/view/widgets/action_dialog_page.dart'
    as _i18;
import 'package:flutter_sharez/features/settings/view/settings_page.dart'
    deferred as _i17;
import 'package:flutter_sharez/features/update_app_version/view/changelog_page.dart'
    deferred as _i1;

/// generated route for
/// [_i1.ChangelogPage]
class ChangelogRoute extends _i19.PageRouteInfo<ChangelogRouteArgs> {
  ChangelogRoute({
    _i20.Key? key,
    required _i21.UpdateModel? updateModel,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          ChangelogRoute.name,
          args: ChangelogRouteArgs(
            key: key,
            updateModel: updateModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangelogRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangelogRouteArgs>();
      return _i19.DeferredWidget(
        _i1.loadLibrary,
        () => _i1.ChangelogPage(
          key: args.key,
          updateModel: args.updateModel,
        ),
      );
    },
  );
}

class ChangelogRouteArgs {
  const ChangelogRouteArgs({
    this.key,
    required this.updateModel,
  });

  final _i20.Key? key;

  final _i21.UpdateModel? updateModel;

  @override
  String toString() {
    return 'ChangelogRouteArgs{key: $key, updateModel: $updateModel}';
  }
}

/// generated route for
/// [_i2.ConfirmConnectionDialogPage]
class ConfirmConnectionDialogRoute
    extends _i19.PageRouteInfo<ConfirmConnectionDialogRouteArgs> {
  ConfirmConnectionDialogRoute({
    _i20.Key? key,
    required _i22.ReceiverModel receiverModel,
    required void Function(bool) onCofirmation,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmConnectionDialogRouteArgs>();
      return _i19.DeferredWidget(
        _i2.loadLibrary,
        () => _i2.ConfirmConnectionDialogPage(
          key: args.key,
          receiverModel: args.receiverModel,
          onCofirmation: args.onCofirmation,
        ),
      );
    },
  );
}

class ConfirmConnectionDialogRouteArgs {
  const ConfirmConnectionDialogRouteArgs({
    this.key,
    required this.receiverModel,
    required this.onCofirmation,
  });

  final _i20.Key? key;

  final _i22.ReceiverModel receiverModel;

  final void Function(bool) onCofirmation;

  @override
  String toString() {
    return 'ConfirmConnectionDialogRouteArgs{key: $key, receiverModel: $receiverModel, onCofirmation: $onCofirmation}';
  }
}

/// generated route for
/// [_i3.CounterPage]
class CounterRoute extends _i19.PageRouteInfo<void> {
  const CounterRoute({List<_i19.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i3.loadLibrary,
        () => _i3.CounterPage(),
      );
    },
  );
}

/// generated route for
/// [_i4.DeviceInfoTabPage]
class DeviceInfoTabRoute extends _i19.PageRouteInfo<DeviceInfoTabRouteArgs> {
  DeviceInfoTabRoute({
    _i20.Key? key,
    required _i23.SenderModel senderModel,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          DeviceInfoTabRoute.name,
          args: DeviceInfoTabRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DeviceInfoTabRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DeviceInfoTabRouteArgs>();
      return _i19.DeferredWidget(
        _i4.loadLibrary,
        () => _i4.DeviceInfoTabPage(
          key: args.key,
          senderModel: args.senderModel,
        ),
      );
    },
  );
}

class DeviceInfoTabRouteArgs {
  const DeviceInfoTabRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i20.Key? key;

  final _i23.SenderModel senderModel;

  @override
  String toString() {
    return 'DeviceInfoTabRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i5.DeviceSharePage]
class DeviceShareRoute extends _i19.PageRouteInfo<DeviceShareRouteArgs> {
  DeviceShareRoute({
    _i20.Key? key,
    required _i23.SenderModel senderModel,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          DeviceShareRoute.name,
          args: DeviceShareRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DeviceShareRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DeviceShareRouteArgs>();
      return _i19.DeferredWidget(
        _i5.loadLibrary,
        () => _i5.DeviceSharePage(
          key: args.key,
          senderModel: args.senderModel,
        ),
      );
    },
  );
}

class DeviceShareRouteArgs {
  const DeviceShareRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i20.Key? key;

  final _i23.SenderModel senderModel;

  @override
  String toString() {
    return 'DeviceShareRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i6.DownloadsPage]
class DownloadsRoute extends _i19.PageRouteInfo<void> {
  const DownloadsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          DownloadsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i6.loadLibrary,
        () => _i6.DownloadsPage(),
      );
    },
  );
}

/// generated route for
/// [_i7.FileSelectorPage]
class FileSelectorRoute extends _i19.PageRouteInfo<void> {
  const FileSelectorRoute({List<_i19.PageRouteInfo>? children})
      : super(
          FileSelectorRoute.name,
          initialChildren: children,
        );

  static const String name = 'FileSelectorRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i7.loadLibrary,
        () => _i7.FileSelectorPage(),
      );
    },
  );
}

/// generated route for
/// [_i8.HelpDialogPage]
class HelpDialogRoute extends _i19.PageRouteInfo<void> {
  const HelpDialogRoute({List<_i19.PageRouteInfo>? children})
      : super(
          HelpDialogRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpDialogRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i8.loadLibrary,
        () => _i8.HelpDialogPage(),
      );
    },
  );
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i9.loadLibrary,
        () => _i9.HomePage(),
      );
    },
  );
}

/// generated route for
/// [_i10.ManualConnectPage]
class ManualConnectRoute extends _i19.PageRouteInfo<void> {
  const ManualConnectRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ManualConnectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManualConnectRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i10.loadLibrary,
        () => _i10.ManualConnectPage(),
      );
    },
  );
}

/// generated route for
/// [_i11.QrScanPage]
class QrScanRoute extends _i19.PageRouteInfo<void> {
  const QrScanRoute({List<_i19.PageRouteInfo>? children})
      : super(
          QrScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScanRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i11.loadLibrary,
        () => _i11.QrScanPage(),
      );
    },
  );
}

/// generated route for
/// [_i12.ReceivePage]
class ReceiveRoute extends _i19.PageRouteInfo<void> {
  const ReceiveRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ReceiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i12.loadLibrary,
        () => _i12.ReceivePage(),
      );
    },
  );
}

/// generated route for
/// [_i13.ReceiveStatePage]
class ReceiveStateRoute extends _i19.PageRouteInfo<void> {
  const ReceiveStateRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ReceiveStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiveStateRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i13.loadLibrary,
        () => _i13.ReceiveStatePage(),
      );
    },
  );
}

/// generated route for
/// [_i14.SendPage]
class SendRoute extends _i19.PageRouteInfo<void> {
  const SendRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i14.loadLibrary,
        () => _i14.SendPage(),
      );
    },
  );
}

/// generated route for
/// [_i15.SendStatePage]
class SendStateRoute extends _i19.PageRouteInfo<void> {
  const SendStateRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SendStateRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendStateRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i15.loadLibrary,
        () => _i15.SendStatePage(),
      );
    },
  );
}

/// generated route for
/// [_i16.SenderFilesTabPage]
class SenderFilesTabRoute extends _i19.PageRouteInfo<SenderFilesTabRouteArgs> {
  SenderFilesTabRoute({
    _i20.Key? key,
    required _i23.SenderModel senderModel,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          SenderFilesTabRoute.name,
          args: SenderFilesTabRouteArgs(
            key: key,
            senderModel: senderModel,
          ),
          initialChildren: children,
        );

  static const String name = 'SenderFilesTabRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SenderFilesTabRouteArgs>();
      return _i19.DeferredWidget(
        _i16.loadLibrary,
        () => _i16.SenderFilesTabPage(
          key: args.key,
          senderModel: args.senderModel,
        ),
      );
    },
  );
}

class SenderFilesTabRouteArgs {
  const SenderFilesTabRouteArgs({
    this.key,
    required this.senderModel,
  });

  final _i20.Key? key;

  final _i23.SenderModel senderModel;

  @override
  String toString() {
    return 'SenderFilesTabRouteArgs{key: $key, senderModel: $senderModel}';
  }
}

/// generated route for
/// [_i17.SettingsPage]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.DeferredWidget(
        _i17.loadLibrary,
        () => _i17.SettingsPage(),
      );
    },
  );
}

/// generated route for
/// [_i18.StopServerActionDialogPage]
class StopServerActionDialogRoute
    extends _i19.PageRouteInfo<StopServerActionDialogRouteArgs> {
  StopServerActionDialogRoute({
    _i20.Key? key,
    required _i20.VoidCallback onYesClicked,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          StopServerActionDialogRoute.name,
          args: StopServerActionDialogRouteArgs(
            key: key,
            onYesClicked: onYesClicked,
          ),
          initialChildren: children,
        );

  static const String name = 'StopServerActionDialogRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StopServerActionDialogRouteArgs>();
      return _i18.StopServerActionDialogPage(
        key: args.key,
        onYesClicked: args.onYesClicked,
      );
    },
  );
}

class StopServerActionDialogRouteArgs {
  const StopServerActionDialogRouteArgs({
    this.key,
    required this.onYesClicked,
  });

  final _i20.Key? key;

  final _i20.VoidCallback onYesClicked;

  @override
  String toString() {
    return 'StopServerActionDialogRouteArgs{key: $key, onYesClicked: $onYesClicked}';
  }
}
