import 'package:auto_route/auto_route.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(
          page: SendRoute.page,
          path: '',
          initial: true,
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'selectFiles',
            ),
            AutoRoute(
              page: FileSelector.page,
              path: 'selectFiles',
            ),
            AutoRoute(
              page: SendStateRoute.page,
              path: 'sendState',
            ),
          ],
        ),
        AutoRoute(
          page: ReceiveRoute.page,
          path: 'receive',
        )
      ],
    ),
    AutoRoute(
      page: DownloadsRoute.page,
      path: '/download',
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
    )
  ];
}
