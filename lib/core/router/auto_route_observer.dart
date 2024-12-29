// ignore_for_file: strict_raw_type

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';

/// This class observers all events happening in routing/navigation
class RouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    talker.debug(
        'New route pushed: ${route.settings.name} Previous route is: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    talker.debug(
        'Previous route poped: ${route.settings.name} Active route is: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    talker.debug(
        'Route ${newRoute?.settings.name} is replaced with ${oldRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    talker.debug(
        'Route ${route.settings.name} is removed. Previous route is:  ${previousRoute?.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    talker.debug(
        'Tab route visited: ${route.name} Previous route is: ${previousRoute?.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    talker.debug(
        'Tab route re-visited: ${route.name} Previous route is: ${previousRoute.name}');
  }
}
