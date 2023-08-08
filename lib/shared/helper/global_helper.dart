// coverage:ignore-file

import 'dart:async';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

///This mixin used for showing dialogs,overlay,bootomsheet,snackbars which automatically disposed
///when the stateful class use this class disposes.s
mixin GlobalHelper<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  Completer completer = Completer();

  Future<S?> showCustomDialog<S>({
    required BuildContext context,
    required WidgetBuilder builder,
    String? routerName,
    bool barrierDismissible = true,
  }) {
    return showDialog<S>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      routeSettings:
          routerName != null ? RouteSettings(name: routerName) : null,
      builder: (BuildContext buildContext) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return pageChild;
            },
          ),
        );
      },
    );
  }

  void showCustomOverlay({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Builder(
          builder: builder,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void showCProgressOverlay({
    required BuildContext context,
    required TickerProvider vsync,
  }) {
    _animationController = AnimationController(
      vsync: vsync,
      value: 0,
    );

    showCustomOverlay(
      context: context,
      builder: (context) => ColoredBox(
        color: Colors.black54,
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController!.view,
            builder: (BuildContext context, Widget? child) {
              return CircularProgressIndicator(
                value: _animationController?.value,
              );
            },
          ),
        ),
      ),
    );
  }

  set updateProgress(double value) {
    _animationController?.value = value;
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _animationController?.dispose();
  }

  Future<T?> showCustomBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = false,
    bool enableDrag = false,
    bool useSafeArea = true,
    double? elevation,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: builder,
      enableDrag: false,
      elevation: elevation,
    );
  }

  void hideBottomSheet({
    required BuildContext context,
  }) {
    Navigator.of(context).pop();
  }

  void hideDialog() {
    Navigator.of(context).pop();
  }

  Future<S?> showBasicFlash<S>({
    required Widget content,
    required VoidCallback onConfirm,
    Widget? icon,
    Widget? title,
    List<Widget>? actions,
  }) async {
    if (context.mounted) {
      await context.showFlash<S>(
        builder: (context, controller) => FlashBar(
          controller: controller,
          indicatorColor: Colors.red,
          icon: const Icon(Icons.tips_and_updates_outlined),
          title: title,
          content: content,
          actions: actions ??
              [
                TextButton(
                  onPressed: controller.dismiss,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    onConfirm();
                    controller.dismiss();
                  },
                  child: const Text('Confirm'),
                )
              ],
        ),
      );
    }
    return null;
  }

  void showFlashOverlay({
    required Widget content,
    Widget? title,
    Widget? icon,
  }) {
    completer = Completer();
    context.showFlash(
      persistent: true,
      dismissCompleter: completer,
      builder: (context, controller) {
        return WillPopScope(
          onWillPop: () async => false,
          child: FlashBar(
            controller: controller,
            margin: const EdgeInsets.all(32.0),
            behavior: FlashBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(
                color: Colors.yellow,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            indicatorColor: Colors.amber,
            title: title,
            icon: icon,
            content: content,
          ),
        );
      },
    );
  }

  void showErrorSnack({
    required Widget child,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(Icons.error_outline),
    Color? indicatorColor = const Color(0xFFE57373),
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      context.showErrorBar(
        content: child,
        duration: duration,
        position: position,
        icon: icon,
        indicatorColor: indicatorColor,
        primaryActionBuilder: showCloseIcon
            ? primaryActionBuilder ??
                (context, controller) {
                  return IconButton(
                    onPressed: controller.dismiss,
                    icon: const Icon(Icons.close),
                  );
                }
            : null,
      );
    }
  }

  void showInfoSnack({
    required Widget child,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(Icons.info_outline),
    Color? indicatorColor = const Color(0xFF64B5F6),
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      context.showInfoBar(
        content: child,
        duration: duration,
        position: position,
        icon: icon,
        indicatorColor: indicatorColor,
        primaryActionBuilder: showCloseIcon
            ? primaryActionBuilder ??
                (context, controller) {
                  return IconButton(
                    onPressed: controller.dismiss,
                    icon: const Icon(Icons.close),
                  );
                }
            : null,
      );
    }
  }

  void showSuccessSnack({
    required Widget child,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(Icons.check_circle_outline),
    Color? indicatorColor = const Color(0xFF81C784),
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      context.showSuccessBar(
        content: child,
        duration: duration,
        position: position,
        icon: icon,
        indicatorColor: indicatorColor,
        primaryActionBuilder: showCloseIcon
            ? primaryActionBuilder ??
                (context, controller) {
                  return IconButton(
                    onPressed: controller.dismiss,
                    icon: const Icon(Icons.close),
                  );
                }
            : null,
      );
    }
  }

  void hideFlashOverlay() {
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  void hideKeyboard() {
    if (context.mounted) {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  void dispose() {
    hideFlashOverlay();
    hideOverlay();
    _animationController?.dispose();
    super.dispose();
  }
}
