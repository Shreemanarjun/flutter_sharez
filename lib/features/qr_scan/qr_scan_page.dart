import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:vibration/vibration.dart';

@RoutePage(
  deferredLoading: true,
)
class QrScanPage extends ConsumerStatefulWidget {
  const QrScanPage({super.key});

  @override
  ConsumerState<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends ConsumerState<QrScanPage> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _found = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (_found) return;
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final value = barcode.rawValue;
                if (value != null && value.startsWith('fshare:')) {
                  setState(() => _found = true);
                  // Haptic locking feedback
                  if (await Vibration.hasVibrator() == true) {
                    Vibration.vibrate(duration: 100);
                  }
                  
                  if (mounted) {
                    context.router.maybePop(value);
                  }
                  break;
                }
              }
            },
          ),
          // Animated Target Scanner
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _found ? Colors.green : theme.colorScheme.primary,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Corner accents
                  _buildCorners(_found ? Colors.green : theme.colorScheme.primary),
                  // Scanning line
                  if (!_found)
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .moveY(begin: 0, end: 248, duration: 2.seconds, curve: Curves.easeInOut)
                        .fadeOut(delay: 1.8.seconds),
                ],
              ),
            )
                .animate(target: _found ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 200.ms)
                .then()
                .shake(duration: 200.ms),
          ),
          // Instructions Overlay
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  _found ? "Code Saved!" : "Align QR within frame",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 60,
            right: 20,
            child: ShadButton.ghost(
              child: const Icon(LucideIcons.x, color: Colors.white, size: 28),
              onPressed: () => context.router.maybePop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorners(Color color) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: _Corner(color: color, quarterTurns: 0),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: _Corner(color: color, quarterTurns: 1),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _Corner(color: color, quarterTurns: 2),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: _Corner(color: color, quarterTurns: 3),
        ),
      ],
    );
  }
}

class _Corner extends StatelessWidget {
  final Color color;
  final int quarterTurns;
  const _Corner({required this.color, required this.quarterTurns});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color, width: 4),
            left: BorderSide(color: color, width: 4),
          ),
        ),
      ),
    );
  }
}
