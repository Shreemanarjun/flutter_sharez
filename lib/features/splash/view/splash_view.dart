import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/features/splash/controller/future_initializer.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';

///This view displayed for initializing all the required things on initialization.
/// This will help for initial loading screen for apps with heavy things initialization;
class SplashView extends ConsumerStatefulWidget {
  /// If true ,this will defer the first frame upto all async initialization done.
  /// On deferring the screen will be blasnk upto the completion of initialization.
  ///
  /// If false, it will show splash loader from the start of the app upto intialization
  ///  without deferring the first frame.
  ///
  final bool removeSpalshLoader;
  final void Function(ProviderContainer container) onInitialized;
  const SplashView({
    super.key,
    required this.onInitialized,
    required this.removeSpalshLoader,
  });

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  late Stopwatch stopwatch;
  @override
  void initState() {
    stopwatch = Stopwatch()..start();
    super.initState();
    if (widget.removeSpalshLoader) {
      RendererBinding.instance.deferFirstFrame();
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.removeSpalshLoader) {
      ref.read(futureInitializerPod.future).whenComplete(
        () {
          RendererBinding.instance.allowFirstFrame();
        },
      );
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    stopwatch.stop();
    talker.info("Page disposed after takes ${stopwatch.elapsedMilliseconds}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final futureAsync = ref.watch(futureInitializerPod);
        ref.listen(
          futureInitializerPod,
          (previous, next) {
            if (next is AsyncData && next.valueOrNull != null) {
              talker.info(
                  "Initialization takes ${stopwatch.elapsedMilliseconds}");
              widget.onInitialized(next.requireValue);
            }
          },
        );
        return futureAsync.easyWhen(
          data: (data) {
            return const SizedBox.shrink();
          },
          loadingWidget: () => child!,
          errorWidget: (error, stackTrace) => child!,
        );
      },
      child: const LoaderChild(),
    );
  }
}

class LoaderChild extends StatefulWidget {
  const LoaderChild({
    super.key,
  });

  @override
  State<LoaderChild> createState() => _LoaderChildState();
}

class _LoaderChildState extends State<LoaderChild>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: RotationTransition(
                turns: _animation,
                child: Image.asset(
                  "assets/images/logo/ic_launcher_adaptive_fore.png",
                  cacheHeight: 200,
                  width: 200,
                ),
              ),
            ),
            const Positioned(
              bottom: 64,
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
            const Positioned(
              bottom: 16,
              child: Material(
                  child: Text(
                "Developed By Shreeman Arjun \n Made with 💙 Riverpod ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
