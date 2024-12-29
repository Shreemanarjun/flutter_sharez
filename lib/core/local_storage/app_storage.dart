import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// This class used for storing data in nosql hive boxes
/// ,reading data and deleting data .
class AppStorage {
  Box? appBox;

  AppStorage(this.appBox);

  Future<void> init({isTest = false}) async {
    appBox = appBox ??
        await Hive.openBox(
          'appBox',
          bytes: isTest ? Uint8List(0) : null,
        );
  }

  /// for getting value as String for a
  /// given key from the box
  String? get({required String key}) {
    return appBox?.get(key) as String?;
  }

  /// for storing value on defined key
  /// on the box
  Future<void> put({
    required String key,
    required String value,
  }) async {
    await appBox?.put(key, value);
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await appBox?.clear();
  }
}
