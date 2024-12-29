import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

///This stream provider class holds stream notifier
final internetCheckerNotifierPod =
    StreamNotifierProvider.autoDispose<InternetStatusNotifier, InternetStatus>(
        InternetStatusNotifier.new);

/// This provider used to when to enable internet checker which
/// can be overriden for default value.
final enableInternetCheckerPod = Provider.autoDispose<bool>((ref) {
  return true;
});

/// This provider used to give a instance Internet Connection Checker
final internetConnectionCheckerInstancePod =
    Provider.autoDispose<InternetConnection>((ref) {
  final internetchecker = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 5),
  );
  return internetchecker;
});

///This stream notifier class handles internet connection status, and changes status if needed
class InternetStatusNotifier extends AutoDisposeStreamNotifier<InternetStatus> {
  @override
  Stream<InternetStatus> build() {
    final enabled = ref.watch(enableInternetCheckerPod);
    if (enabled) {
      final statuschange =
          ref.watch(internetConnectionCheckerInstancePod).onStatusChange;

      return statuschange.distinct();
    } else {
      return Stream.value(InternetStatus.connected);
    }
  }

  void change({required InternetStatus status}) {
    state = AsyncValue.data(status);
  }
}
