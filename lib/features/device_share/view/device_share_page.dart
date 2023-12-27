import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';

import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:velocity_x/velocity_x.dart';

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
        SenderFilesTabRoute(senderModel: senderModel)
      ],
      builder: (context, child, tabsRouter) {
        return Scaffold(
          body: <Widget>[
            ColoredBox(
              color: context.theme.dialogBackgroundColor,
              child: TabBar(
                controller: tabsRouter,
                tabs: const [
                  Tab(
                      text: 'Device Info',
                      icon: Icon(Icons.info_outline_rounded)),
                  Tab(text: 'Files', icon: Icon(Icons.folder_open_outlined)),
                ],
              ),
            ).flexible(),
            child.expand()
          ].vStack(),
        );
      },
    );
  }
}
