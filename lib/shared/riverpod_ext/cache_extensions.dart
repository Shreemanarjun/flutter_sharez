import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///This
extension CacheExtension<T> on Ref<T> {
  KeepAliveLink cacheFor([Duration duration = const Duration(seconds: 3)]) {
    Timer? timer;
    // prevents being disposed
    final link = keepAlive();

    // when the provider is no longer used (removed all listeners)
    // the timer will be started with the given cache duration
    // when the time expires, the link will be closed,
    // and the provider will dispose itself
    onCancel(() => timer = Timer(duration, link.close));

    // when we recall the provider again
    // the timer will be canceled and the link will no longer close.
    onResume(() => timer?.cancel());

    /// if the link is closed, [onDispose] will be called
    /// and if there's a timer it will be canceled
    onDispose(() => timer?.cancel());

    return link;
  }

  /// Automatically refresh after specified [duration]
  void autoRefresh({required Duration duration}) {
    final timer = Timer(duration, invalidateSelf);
    onDispose(timer.cancel);
  }
}
