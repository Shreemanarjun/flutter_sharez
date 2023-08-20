import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    Key? key,
    required this.child,
    this.noInternetWidget,
  }) : super(key: key);
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
              top: context.screenPadding.top,
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
  InternetConnectionStatus? lastResult;
  @visibleForTesting
  void internetListener(InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        //  talker.debug('Data Reconnected.');
        if (lastResult == InternetConnectionStatus.disconnected) {
          ref.invalidate(dioProvider);
        } else {
          //talker.debug('First time');
        }
        break;
      case InternetConnectionStatus.disconnected:
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
          heightFactor:
              status == InternetConnectionStatus.disconnected ? 1.0 : 0.0,
          child: status == InternetConnectionStatus.disconnected
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
      ),
      loading: () => const LinearProgressIndicator(),
    );
  }
}
