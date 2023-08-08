import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/theme/theme_controller.dart';

///This provider gives initial value to theme segment button
final themeSelectionPod = Provider.autoDispose<Set<ThemeMode>>(
  (ref) => <ThemeMode>{ref.watch(themecontrollerProvider)},
  name: "themeSelectionPod",
);
