import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/shared/widget/custom_app_bar.dart';

@RoutePage(
  deferredLoading: true,
)
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        SendRoute(),
        ReceiveRoute(),
      ],
      appBarBuilder: (context, tabsRouter) {
        return CustomAppBar(
          appActions: [
            IconButton(
              onPressed: () {
                context.navigateTo(const DownloadsRoute());
              },
              icon: const Icon(
                Icons.download_outlined,
              ),
              tooltip: 'Downloads',
            ),
            IconButton(
              onPressed: () {
                context.navigateTo(const SettingsRoute());
              },
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'App Settings',
            ),
          ],
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.arrow_upward_outlined),
              label: 'Send',
            ),
            NavigationDestination(
              icon: Icon(Icons.arrow_downward_outlined),
              label: 'Receive',
            ),
          ],
        );
      },
    );
  }
}
