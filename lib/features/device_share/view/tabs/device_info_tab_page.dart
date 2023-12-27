import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class DeviceInfoTabPage extends StatelessWidget {
  final SenderModel senderModel;
  const DeviceInfoTabPage({super.key, required this.senderModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: "Host: ${senderModel.host}".text.make(),
        ),
        ListTile(
          title: "IP: ${senderModel.ip}".text.make(),
        ),
        ListTile(
          title: "Port: ${senderModel.port}".text.make(),
        ),
        ListTile(
          title: "OS: ${senderModel.os}".text.make(),
          trailing: OSLogo(os: senderModel.os),
        ),
        ListTile(
          title: "Version: ${senderModel.version}".text.make(),
        )
      ],
    );
  }
}
