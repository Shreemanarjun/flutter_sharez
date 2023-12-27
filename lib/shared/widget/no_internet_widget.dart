import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';
import 'package:velocity_x/velocity_x.dart';

///No internet extension widget
extension NoInternet on Widget {
  Widget monitorConnection({
    Widget? noInternetWidget,
  }) {
    return ConnectionMonitor(
      noInternetWidget: noInternetWidget,
      child: this,
    );
  }
}

///This class handles internet status and according to that handles ui

class ConnectionMonitor extends StatelessWidget {
  const ConnectionMonitor({
    super.key,
    required this.child,
    this.noInternetWidget,
  });
  final Widget child;
  final Widget? noInternetWidget;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          child,
          Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: AnimatedSize(
                duration: 900.milliseconds,
                curve: Curves.fastOutSlowIn,
                alignment: Alignment.topCenter,
                child: DefaultNoInternetWidget(
                  noInternetWidget: noInternetWidget,
                ),
              ))
        ],
      ),
    );
  }
}

class DefaultNoInternetWidget extends ConsumerStatefulWidget {
  const DefaultNoInternetWidget({
    super.key,
    this.noInternetWidget,
  });
  final Widget? noInternetWidget;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DefaultNoInternetState();
}

class _DefaultNoInternetState extends ConsumerState<DefaultNoInternetWidget> {
  InternetStatus? lastResult;
  @visibleForTesting
  void internetListener(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        //  talker.debug('Data Reconnected.');
        if (lastResult == InternetStatus.disconnected) {
          ref.invalidate(dioProvider);
        } else {
          //talker.debug('First time');
        }
        break;
      case InternetStatus.disconnected:
    }
    lastResult = status;
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(internetCheckerPod);
    ref.listen(
      internetCheckerPod,
      (previous, next) {
        if (next is AsyncData) {
          final status = next.value;
          if (status != null) {
            internetListener(status);
          }
        }
      },
    );
    return statusAsync.when(
      data: (status) {
        return Align(
          alignment: Alignment.topCenter,
          heightFactor: status == InternetStatus.disconnected ? 1.0 : 0.0,
          child: status == InternetStatus.disconnected
              ? ((widget.noInternetWidget) ??
                      MaterialBanner(
                        content: const Text(
                          'No Internet Available',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(internetCheckerPod);
                            },
                            child: const Text(
                              'OK',
                              key: ValueKey('OK_BUTTON'),
                            ),
                          ),
                        ],
                      ))
                  .safeArea()
              : const SizedBox.shrink(),
        );
      },
      error: (error, stackTrace) => MaterialBanner(
        content:
            Text("Unable to check internet due to $error").text.red500.make(),
        actions: [
          ElevatedButton(
            onPressed: () {
              ref.invalidate(internetCheckerPod);
            },
            child: const Text('Retry').text.red500.make(),
          ),
        ],
      ).safeArea(),
      loading: () => const LinearProgressIndicator(),
    );
  }
}
