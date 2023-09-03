import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/shared/widget/app_logo.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends AppBar {
  final Widget? appTitle;
  final List<Widget>? appActions;
  CustomAppBar({super.key, this.appTitle, this.appActions})
      : super(
            elevation: 0,
            leading: const AutoLeadingButton(
              ignorePagelessRoutes: true,
              showIfParentCanPop: false,
            ),
            centerTitle: true,
            title: <Widget>[
              const AppLogo().py8(),
              if (appTitle != null) appTitle
            ].aStack(),
            actions: <Widget>[if (appActions != null) ...appActions]);
}
