import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/splash/controller/initializer_notifier.dart';
import 'package:lottie/lottie.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker();

/// This view is displayed for initializing all the required things on initialization.
/// This will help for initial loading screen for apps with heavy things initialization;
class SplashView extends ConsumerStatefulWidget {
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
    talker.info("SplashView initState");
    // Start initialization after the first frame to allow smooth animation start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(initializerPod.notifier).start();
    });
  }

  @override
  void dispose() {
    stopwatch.stop();
    talker.info("SplashView disposed. Lifetime: ${stopwatch.elapsedMilliseconds}ms");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for success state to trigger the callback
    ref.listen<InitializerState>(initializerPod, (previous, next) {
      if (next.status == InitializationStatus.success) {
        final container = next.container;
        if (container != null) {
          talker.info("Initialization success in ${stopwatch.elapsedMilliseconds}ms");
          widget.onInitialized(container);
        }
      }
    });

    final state = ref.watch(initializerPod);

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
                    frameRate: FrameRate.max,
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
                SizedBox(
                  width: 40,
                  height: 40,
                  child: state.status == InitializationStatus.failure
                      ? const Icon(Icons.error_outline, color: Colors.red, size: 40)
                      : const CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.step.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: state.status == InitializationStatus.failure
                        ? Colors.red
                        : Colors.black38,
                  ),
                ),
                if (state.status == InitializationStatus.failure)
                  TextButton(
                    onPressed: () => ref.read(initializerPod.notifier).start(),
                    child: const Text("RETRY"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
