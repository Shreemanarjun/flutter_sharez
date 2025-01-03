import 'package:file_picker/file_picker.dart';
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

final futureInitializerPod =
    FutureProvider.autoDispose<ProviderContainer>((ref) async {
  ///Additional intial delay duration for app
  // await Future.delayed(const Duration(seconds: 1));
  await (init());
  await Hive.initFlutter();

  AppLocale deviceLocale = AppLocaleUtils.findDeviceLocale();
  final translations = await deviceLocale.build();

  ///Replace `appBox` namw with any key you want

  final encryptionCipher = await Platform.I.when(
    mobile: () async {
      final encryptionKey = await ref.watch(boxEncryptionKeyPod.future);
      return HiveAesCipher(encryptionKey);
    },
  );

  final appBox = await Hive.openBox(
    'FlutterSharezBox',
    encryptionCipher: encryptionCipher,
  );
  return ProviderContainer(
    overrides: [
      appBoxProvider.overrideWithValue(appBox),
      translationsPod.overrideWith(
        (ref) => translations,
      )
    ],
    observers: [
      ///Added new talker riverpod observer
      ///
      /// If you want old behaviour
      /// Replace with
      ///
      ///  MyObserverLogger( talker: talker,)
      ///
      ///
      ///
      ///
      TalkerRiverpodObserver(
        talker: talker,
        settings: const TalkerRiverpodLoggerSettings(
          printProviderDisposed: true,
        ),
      ),
    ],
  );
});
