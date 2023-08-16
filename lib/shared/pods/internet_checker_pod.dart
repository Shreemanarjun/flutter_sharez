import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

///This stream provider class holds stream notifier
final internetCheckerPod = StreamNotifierProvider.autoDispose<
    InternetStatusNotifier,
    InternetConnectionStatus>(InternetStatusNotifier.new);

/// This provider used to when to enable internet checker which
/// can be overriden for default value.
final enableInternetCheckerPod = Provider.autoDispose<bool>((ref) {
  return true;
});

/// This provider used to give a instance Internet Connection Checker
final internetConnectionCheckerPod =
    Provider.autoDispose<InternetConnectionChecker>((ref) {
  final internetchecker = InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 5),
  );
  return internetchecker;
});

///This stream notifier class handles internet connection status, and changes status if needed
class InternetStatusNotifier
    extends AutoDisposeStreamNotifier<InternetConnectionStatus> {
  @override
  Stream<InternetConnectionStatus> build() {
    final enabled = ref.watch(enableInternetCheckerPod);
    if (enabled) {
      final statuschange =
          ref.watch(internetConnectionCheckerPod).onStatusChange;

      return statuschange.distinct();
    }
    return Stream.value(InternetConnectionStatus.connected);
  }

  void change({required InternetConnectionStatus status}) {
    state = AsyncValue.data(status);
  }
}
