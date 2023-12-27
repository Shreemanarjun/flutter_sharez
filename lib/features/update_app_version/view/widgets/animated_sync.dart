import 'package:flutter/material.dart';

class SpinningIconButton extends StatefulWidget {
  final IconData iconData;

  const SpinningIconButton({
    super.key,
    required this.iconData,
  });

  @override
  State<SpinningIconButton> createState() => _SpinningIconButtonState();
}

class _SpinningIconButtonState extends State<SpinningIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animation = CurvedAnimation(
      parent: controller,
      // Use whatever curve you would like, for more details refer to the Curves class
      curve: Curves.linearToEaseOut,
    );
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: _animation,
        child: IconButton(
          icon: Icon(widget.iconData),
          onPressed: null,
        ));
  }
}
