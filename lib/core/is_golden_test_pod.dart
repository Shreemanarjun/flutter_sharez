import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to detect if we are running in a golden test environment
/// to disable infinite animations/Lottie loops.
final isGoldenTestProvider = Provider<bool>((ref) => false);
