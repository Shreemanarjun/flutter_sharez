import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension DebounceExtension<T> on Ref<T> {
  /// delays the execution of the code for the given duration,
  /// if any dependency changes during the period,
  /// the timer will reset and restart
  /// if nothing changes, the rest of the code will be executed.
  Future<void> debounce([
    Duration duration = const Duration(milliseconds: 350),
  ]) {
    final completer = Completer<void>();

    /// creates a timer with the given duration
    /// when the time expires, and the completer hasn't completed yet, complete it.
    /// and the debounce function lets the rest of the code executed
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });

    /// if provider disposed and the completer hasn't completed yet
    /// cancel the timer and throw canceled error
    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.complete();
        // completer.completeError(StateError('Canceled'));
      }
    });

    return completer.future;
  }
}
