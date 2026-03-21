import 'package:flutter/material.dart';

class AppGestureDetector extends StatelessWidget {
  const AppGestureDetector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
