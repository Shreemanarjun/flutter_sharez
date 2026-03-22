import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/features/splash/controller/box_encryption_key_pod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/init.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

enum InitializationStatus { idle, initializing, success, failure }

class InitializerState {
  final InitializationStatus status;
  final String step;
  final ProviderContainer? container;
  final Object? error;
  final StackTrace? stackTrace;

  InitializerState({
    this.status = InitializationStatus.idle,
    this.step = "Starting...",
    this.container,
    this.error,
    this.stackTrace,
  });

  InitializerState copyWith({
    InitializationStatus? status,
    String? step,
    ProviderContainer? container,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return InitializerState(
      status: status ?? this.status,
      step: step ?? this.step,
      container: container ?? this.container,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

class InitializerNotifier extends Notifier<InitializerState> {
  @override
  InitializerState build() {
    return InitializerState();
  }

  Future<void> start() async {
    if (state.status == InitializationStatus.initializing ||
        state.status == InitializationStatus.success) {
      return;
    }

    state = state.copyWith(
      status: InitializationStatus.initializing,
      step: "Sharez is starting...",
    );

    await Future.delayed(const Duration(milliseconds: 300));

    try {
      talker.info("Starting initialization process...");

      await init();
      await _breathe();

      state = state.copyWith(step: "Preparing storage...");
      await Hive.initFlutter('hive');
      await _breathe();

      state = state.copyWith(step: "Applying settings...");
      AppLocale deviceLocale = AppLocaleUtils.findDeviceLocale();
      final translations = await deviceLocale.build();
      await _breathe();

      HiveAesCipher? encryptionCipher;
      if (platform.mobile) {
        state = state.copyWith(step: "Securing storage...");
        final encryptionKey = await ref.read(boxEncryptionKeyPod.future);
        encryptionCipher = HiveAesCipher(encryptionKey);
        await _breathe();
      }

      state = state.copyWith(step: "Opening data box...");
      talker.info("Opening Hive box 'FlutterSharezBox'...");
      final appBox = await Hive.openBox(
        'FlutterSharezBox',
        encryptionCipher: encryptionCipher,
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Hive box opening timed out.");
      });
      talker.info("Hive box opened successfully.");
      await _breathe();

      state = state.copyWith(step: "Finalizing setups...");
      final container = ProviderContainer(
        overrides: [
          appBoxProvider.overrideWithValue(appBox),
          translationsPod.overrideWith((ref) => translations)
        ],
        observers: [
          TalkerRiverpodObserver(
            talker: talker,
            settings: const TalkerRiverpodLoggerSettings(
              printProviderDisposed: true,
            ),
          ),
        ],
      );

      state = state.copyWith(
        status: InitializationStatus.success,
        step: "Initialization Complete",
        container: container,
      );
      talker.info("Initialization sequence completed successfully.");
    } catch (e, st) {
      talker.error("Failed to initialize app: $e", e, st);
      state = state.copyWith(
        status: InitializationStatus.failure,
        step: "Initialization Failed: $e",
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _breathe() => Future.delayed(const Duration(milliseconds: 50));
}

final initializerPod = NotifierProvider<InitializerNotifier, InitializerState>(
    InitializerNotifier.new);
