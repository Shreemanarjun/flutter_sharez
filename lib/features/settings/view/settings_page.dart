import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Settings'.text.make(),
      ),
      body: ThemeSegmentedBtn().centered(),
    );
  }
}
