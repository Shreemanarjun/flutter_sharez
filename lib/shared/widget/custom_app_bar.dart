import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/shared/widget/app_logo.dart';

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
          title: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: AppLogo(),
              ),
              if (appTitle != null) appTitle
            ],
          ),
          actions: [if (appActions != null) ...appActions],
        );
}
