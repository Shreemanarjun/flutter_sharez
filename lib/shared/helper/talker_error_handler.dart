import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerErrorHandler extends StatefulWidget {
  final Widget child;
  const TalkerErrorHandler({super.key, required this.child});

  @override
  State<TalkerErrorHandler> createState() => _TalkerErrorHandlerState();
}

class _TalkerErrorHandlerState extends State<TalkerErrorHandler> {
  @override
  void initState() {
    super.initState();
    talker.stream.listen((event) {
      if (event is TalkerError || event is TalkerException) {
        _showErrorToast(event.message ?? "An unexpected error occurred");
      }
    });
  }

  void _showErrorToast(String message) {
    if (mounted) {
      context.showFlash(
        duration: const Duration(seconds: 4),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            behavior: FlashBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.red.shade800,
            content: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.error_outline, color: Colors.white),
            position: FlashPosition.bottom,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
