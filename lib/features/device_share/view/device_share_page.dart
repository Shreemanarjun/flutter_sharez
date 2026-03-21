import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage(
  deferredLoading: true,
)
class DeviceSharePage extends StatelessWidget {
  final SenderModel senderModel;
  const DeviceSharePage({super.key, required this.senderModel});

  @override
  Widget build(BuildContext context) {
    return DeviceShareView(
      senderModel: senderModel,
    );
  }
}

class DeviceShareView extends StatelessWidget {
  final SenderModel senderModel;
  const DeviceShareView({super.key, required this.senderModel});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        DeviceInfoTabRoute(senderModel: senderModel),
        SenderFilesTabRoute(senderModel: senderModel),
        const FileSelectorRoute(),
      ],
      builder: (context, child, tabsRouter) {
        final theme = ShadTheme.of(context);
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: AppBar(
            backgroundColor: theme.colorScheme.background,
            title: Text(
              senderModel.host ?? 'Device',
              style: theme.textTheme.h4,
            ),
            elevation: 0,
            bottom: TabBar(
              controller: tabsRouter,
              indicatorColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.mutedForeground,
              tabs: const [
                Tab(
                  text: 'Info',
                  icon: Icon(LucideIcons.info),
                ),
                Tab(
                  text: 'Remote Files',
                  icon: Icon(LucideIcons.download),
                ),
                Tab(
                  text: 'My Files',
                  icon: Icon(LucideIcons.upload),
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
