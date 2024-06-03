import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///This
extension CacheExtension<T> on AutoDisposeRef<T> {
  KeepAliveLink cacheFor([Duration duration = const Duration(seconds: 3)]) {
    Timer? timer;
    // prevents being disposed
    final link = keepAlive();

    // when the provider is no longer used (removed all listeners)
    // the timer will be started with the given cache duration
    // when the time expires, the link will be closed,
    // and the provider will dispose itself
    onCancel(() {
      timer?.cancel();
      link.close();
    });

    /// uncomment for better caching leaking fix
    ///    // when we recall the provider again
    // the timer will be canceled and the link will no longer close.
    // onResume(() {
    //   timer?.cancel();
    //   timer = Timer(duration, link.close);
    // });

    timer = Timer(duration, link.close);

    return link;
  }

  /// Refreshes the provider's value automatically at a specified interval.
  ///
  /// This method is best suited for scenarios where real-time data updates are required.
  void autoRefresh({required Duration duration}) {
    final timer = Timer.periodic(duration, (_) => invalidateSelf());
    onDispose(timer.cancel);
  }
}
