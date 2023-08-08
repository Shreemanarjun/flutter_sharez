import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';

/// This provider used for App Storage Service class which
/// depends on appBoxProvider for getting intial Hive Box
final appStorageProvider = Provider.autoDispose<AppStorage>(
  (ref) => AppStorage(ref.watch(appBoxProvider)),
  name: 'appStorageProvider',
);

/// This provider used for Storing Hive Box which you can override on
/// bootstrap function on start of the app
final appBoxProvider = Provider.autoDispose<Box>(
  (ref) => throw UnimplementedError("appBoxProvider is not overriden"),
  name: 'appBoxProvider',
);
