import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';

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
          title: Text("Host: ${senderModel.host}"),
        ),
        ListTile(
          title: Text("IP: ${senderModel.ip}"),
        ),
        ListTile(
          title: Text("Port: ${senderModel.port}"),
        ),
        ListTile(
          title: Text("OS: ${senderModel.os}"),
          trailing: OSLogo(os: senderModel.os),
        ),
        ListTile(
          title: Text("Version: ${senderModel.version}"),
        )
      ],
    );
  }
}
