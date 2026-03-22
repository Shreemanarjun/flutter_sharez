import 'package:flutter/material.dart';
import 'package:flutter_sharez/app/view/app.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlobalShadResponsiveWrapper(
      child: child,
    );
  }
}
