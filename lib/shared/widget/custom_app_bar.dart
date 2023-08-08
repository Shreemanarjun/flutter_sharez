import 'package:flutter/material.dart';
import 'package:flutter_sharez/shared/widget/app_logo.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends AppBar {
  final Widget? appTitle;
  final List<Widget>? appActions;
  CustomAppBar({super.key, this.appTitle, this.appActions})
      : super(
            elevation: 0,
            centerTitle: true,
            title: <Widget>[
              const AppLogo().py8(),
              if (appTitle != null) appTitle
            ].aStack(),
            actions: <Widget>[
              
              if (appActions != null) 
              ...appActions
            ]);
}
