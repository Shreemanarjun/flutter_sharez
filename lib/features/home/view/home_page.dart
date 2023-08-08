import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

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
