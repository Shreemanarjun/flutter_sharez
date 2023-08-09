import 'package:flutter/material.dart';

class OSLogo extends StatelessWidget {
  final String? os;
  const OSLogo({
    super.key,
    required this.os,
  });

  @override
  Widget build(BuildContext context) {
    if (os == "windows") {
      return const ImageIcon(
        NetworkImage("https://img.icons8.com/fluency/48/000000/windows-10.png"),
        color: Colors.blue,
      );
    } else if (os == "macos") {
      return const ImageIcon(
        NetworkImage(
            "https://img.icons8.com/tiny-color/64/null/mac-client--v2.png"),
      );
    } else if (os == "linux") {
      return const ImageIcon(
        NetworkImage("https://img.icons8.com/color/48/000000/linux--v1.png"),
        color: Colors.yellow,
      );
    } else if (os == "android") {
      return const ImageIcon(
        NetworkImage("https://img.icons8.com/fluency/96/000000/android-os.png"),
        color: Colors.green,
      );
    } else if (os == "ios") {
      return const ImageIcon(
        NetworkImage(
            "https://img.icons8.com/ios-filled/50/000000/ios-logo.png"),
        color: Colors.black,
      );
    } else {
      return const Icon(Icons.laptop);
    }
  }
}
