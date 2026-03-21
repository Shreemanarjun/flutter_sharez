import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sharez/splasher.dart';
import 'package:rhttp/rhttp.dart';

/// This entry point should be used for production only
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Rhttp.init(); // add this
  runApp(
    ProviderScope(
      child: Splasher(),
    ),
  );
}
