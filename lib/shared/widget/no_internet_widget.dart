import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_sharez/shared/api_client/dio/dio_client_provider.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/pods/internet_checker_pod.dart';

///No internet extension widget
extension NoInternet on Widget {
  Widget noInternetWidget({
    bool maintainState = true,
    bool enableCheck = true,
    Widget? noInternetWidget,
  }) {
    return InternetCheckerWidget(
      ///Maintain state is by default true
      ///which will maintain by default the state of your app
      ///Whether to maintain the [State] objects of the [child] subtree when it is not [visible].
      maintainState: maintainState,
      noInternetWidget: noInternetWidget,

      ///Whether the enable checking no internet widget
      enableCheck: enableCheck,
      child: this,
    );
  }
}

///This class handles internet status and according to that handles ui
class InternetCheckerWidget extends ConsumerStatefulWidget {
  const InternetCheckerWidget({
    required this.child,
    required this.maintainState,
    this.noInternetWidget,
    required this.enableCheck,
    super.key,
  });
  final Widget child;
  final bool maintainState;
  final Widget? noInternetWidget;
  final bool enableCheck;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoInternetWidgetState();
}

class _NoInternetWidgetState extends ConsumerState<InternetCheckerWidget>
    with GlobalHelper {
  InternetConnectionStatus? lastResult;
  @visibleForTesting
  void internetListener(
    InternetConnectionStatus status, {
    required void Function() onNoInternetOKPressed,
  }) {
    switch (status) {
      case InternetConnectionStatus.connected:
        //  talker.debug('Data Reconnected.');
        if (lastResult == InternetConnectionStatus.disconnected) {
          ref.invalidate(dioProvider);
          ScaffoldMessenger.of(context)
            ..clearMaterialBanners()
            ..showMaterialBanner(
              MaterialBanner(
                content: const Text(
                  'Got Internet ...... Refreshed',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
            );
          });
        } else {
          //talker.debug('First time');
        }

        break;
      case InternetConnectionStatus.disconnected:
        // talker.debug('You are disconnected from the internet.');
        ScaffoldMessenger.of(context)
          ..clearMaterialBanners()
          ..showMaterialBanner(
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
                    onNoInternetOKPressed();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        break;
    }
    lastResult = status;
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(internetCheckerPod);
    ref.listen(
      internetCheckerPod,
      (previous, next) {
        final status = next.value;
        if (status != null) {
          internetListener(
            status,
            onNoInternetOKPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
              ref.invalidate(internetCheckerPod);
            },
          );
        }
      },
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: widget.enableCheck
          ? statusAsync.when(
              data: (status) {
                if (widget.maintainState) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: status == InternetConnectionStatus.connected,
                        maintainState: true,
                        child: widget.child,
                      ),
                      if (status == InternetConnectionStatus.disconnected)
                        Scaffold(
                          body: widget.noInternetWidget,
                        ),
                    ],
                  );
                } else {
                  switch (status) {
                    case InternetConnectionStatus.connected:
                      return widget.child;
                    case InternetConnectionStatus.disconnected:
                      return Scaffold(
                        body: widget.noInternetWidget,
                      );
                  }
                }
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : widget.child,
    );
  }
}
