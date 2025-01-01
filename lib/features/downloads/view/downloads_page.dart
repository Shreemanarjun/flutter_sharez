import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.t.downloads.text.make(),
      ),
    );
  }
}
