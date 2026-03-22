import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/splash/controller/future_initializer.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:lottie/lottie.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker();

///This view displayed for initializing all the required things on initialization.
/// This will help for initial loading screen for apps with heavy things initialization;
class SplashView extends ConsumerStatefulWidget {
  /// If true ,this will defer the first frame upto all async initialization done.
  /// On deferring the screen will be blank upto the completion of initialization.
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
            if (next.hasValue) {
              talker.info(
                  "Initialization takes ${stopwatch.elapsedMilliseconds}");
              widget.onInitialized(next.requireValue);
              try {
                FilePicker.platform.clearTemporaryFiles().catchError((e) {
                  talker.error('FilePicker clearTemporaryFiles not implemented: $e');
                  return null;
                });
              } catch (e) {
                talker.error('FilePicker clearTemporaryFiles failed: $e');
              }
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

class LoaderChild extends StatelessWidget {
  const LoaderChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Lottie.asset(
                    'assets/anim/starting_rocket.json',
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Sharez",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Text(
                  "Instant Local Sharing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            child: Column(
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Initializing port...".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
