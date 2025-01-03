import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveBreakPointWrapper extends StatelessWidget {
  final Widget child;

  ///the initial frame 0 width and height issue is still present in the Flutter framework
  final Widget firstFrameWidget;

  const ResponsiveBreakPointWrapper({
    super.key,
    required this.child,
    required this.firstFrameWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: ResponsiveViewWrapper(
        firstFrameWidget: firstFrameWidget,
        child: child,
      ),
      breakpoints: [
        const Breakpoint(start: 0.0, end: 480.0, name: MOBILE),
        const Breakpoint(start: 480.0, end: 1200.0, name: TABLET),
        const Breakpoint(start: 900.0, end: 1920.0, name: DESKTOP),
        const Breakpoint(start: 1921.0, end: double.infinity, name: '4K'),
      ],
    );
  }
}

class ResponsiveViewWrapper extends StatefulWidget {
  final Widget child;

  ///the initial frame 0 width and height issue is still present in the Flutter framework
  final Widget firstFrameWidget;

  const ResponsiveViewWrapper({
    super.key,
    required this.child,
    required this.firstFrameWidget,
  });

  @override
  State<ResponsiveViewWrapper> createState() => _ResponsiveViewWrapperState();
}

class _ResponsiveViewWrapperState extends State<ResponsiveViewWrapper> {
  late ResponsiveBreakpointsData breakpointsData;

  @override
  Widget build(BuildContext context) {
    breakpointsData = ResponsiveBreakpoints.of(context);
    if (breakpointsData.breakpoints.isEmpty) {
      return widget.firstFrameWidget;
    } else {
      return MaxWidthBox(
        maxWidth: 3840,
        child: ResponsiveScaledBox(
          width: ResponsiveValue<double?>(
            context,
            conditionalValues: [
              const Condition.equals(name: MOBILE, value: 400.0),
              const Condition.equals(name: TABLET, value: 800.0),
              const Condition.equals(name: DESKTOP, value: 1800.0),
              const Condition.equals(name: '4K', value: 3840.0),
            ],
          ).value,
          child: BouncingScrollWrapper.builder(
            context,
            widget.child,
            dragWithMouse: true,
          ),
        ),
      );
    }
  }
}
