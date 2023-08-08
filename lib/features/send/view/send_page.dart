import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(
  deferredLoading: true,
)
class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
