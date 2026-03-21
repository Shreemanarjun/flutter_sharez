import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveBreakPointWrapper extends StatelessWidget {
  final Widget child;

  ///the initial frame 0 width and height issue is still present in the Flutter framework
  final Widget firstFrameWidget;
  const ResponsiveBreakPointWrapper(
      {super.key, required this.child, required this.firstFrameWidget});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: ResponsiveViewWrapper(
        firstFrameWidget: firstFrameWidget,
        child: child,
      ),
      breakpoints: [
        const Breakpoint(
            start: 0, end: 639, name: MOBILE), // TN + SM range (0-639px)
        const Breakpoint(
            start: 640, end: 1023, name: TABLET), // MD + LG range (640-1023px)
        const Breakpoint(
            start: 1024,
            end: 1535,
            name: DESKTOP), // XL + XXL range (1024-1535px)
        const Breakpoint(start: 1536, end: double.infinity, name: '4K'),
      ],
    );
  }
}

class ResponsiveViewWrapper extends StatefulWidget {
  final Widget child;

  ///the initial frame 0 width and height issue is still present in the Flutter framework
  final Widget firstFrameWidget;
  const ResponsiveViewWrapper(
      {super.key, required this.child, required this.firstFrameWidget});

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
      return BouncingScrollWrapper.builder(
        context,
        widget.child,
        dragWithMouse: true,
      );
    }
  }
}
