import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/theme/app_theme_pod.dart';

///This provider gives initial value to theme segment button
final themeSelectionPod = Provider.autoDispose<Set<ThemeMode>>(
  (ref) => <ThemeMode>{ref.watch(themeModePod)},
  name: "themeSelectionPod",
);
