import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage_x/flutter_secure_storage_x.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';

final boxEncryptionKeyPod = FutureProvider.autoDispose<Uint8List>((ref) async {
  const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ));

  const secureStorageKey = "FlutterSharez";
  // if key not exists return null
  final encryptionKeyString = await secureStorage.read(key: secureStorageKey);

  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: secureStorageKey,
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: secureStorageKey);
  final encryptionKeyUint8List = base64Url.decode(key!);
  return encryptionKeyUint8List;
});
