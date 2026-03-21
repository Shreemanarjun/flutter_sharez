import 'package:flutter/material.dart';

class MediaQueryWrapper extends StatelessWidget {
  const MediaQueryWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(mediaQuery.textScaleFactor.clamp(0, 1)),
      ),
      child: child,
    );
  }
}
