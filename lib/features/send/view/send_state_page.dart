import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(
  deferredLoading: true,
)
class SendStatePage extends StatelessWidget {
  const SendStatePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
