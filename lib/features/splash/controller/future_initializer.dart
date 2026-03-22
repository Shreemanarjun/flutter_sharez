import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/features/splash/controller/box_encryption_key_pod.dart';
import 'package:flutter_sharez/init.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// Pod to track current initialization step
class InitializationStep extends Notifier<String> {
  @override
  String build() => "Starting Sharez...";

  void update(String step) => state = step;
}

final initializationStepPod =
    NotifierProvider<InitializationStep, String>(InitializationStep.new);

final futureInitializerPod =
    FutureProvider.autoDispose<ProviderContainer>((ref) async {
  talker.info("Starting initialization...");
  ref.read(initializationStepPod.notifier).update("Configuring system...");
  await init();

  ref.read(initializationStepPod.notifier).update("Initializing storage...");
  await Hive.initFlutter('hive');

  ref.read(initializationStepPod.notifier).update("Loading translations...");
  AppLocale deviceLocale = AppLocaleUtils.findDeviceLocale();
  final translations = await deviceLocale.build();

  HiveAesCipher? encryptionCipher;
  if (platform.mobile) {
    ref.read(initializationStepPod.notifier).update("Securing storage...");
    final encryptionKey = await ref.watch(boxEncryptionKeyPod.future);
    encryptionCipher = HiveAesCipher(encryptionKey);
  }

  ref.read(initializationStepPod.notifier).update("Opening database...");
  final appBox = await Hive.openBox(
    'FlutterSharezBox',
    encryptionCipher: encryptionCipher,
  );

  ref.read(initializationStepPod.notifier).update("Launching Sharez...");
  talker.info("App box opened. Initialization complete.");
  return ProviderContainer(
    overrides: [
      appBoxProvider.overrideWithValue(appBox),
      translationsPod.overrideWith(
        (ref) => translations,
      )
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
});
