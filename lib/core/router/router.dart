import 'package:auto_route/auto_route.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: CounterRoute.page,
      path: '/',
      initial: true,
    ),
  ];
}
