import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FileIcon extends StatelessWidget {
  final String fileName;
  final double? size;
  final Color? color;

  const FileIcon({
    super.key,
    required this.fileName,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final extension = fileName.split('.').last.toLowerCase();

    final (icon, iconColor) = _getIconData(context, extension);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (color ?? iconColor).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: size,
        color: color ?? iconColor,
      ),
    );
  }

  (IconData, Color) _getIconData(BuildContext context, String extension) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return switch (extension) {
      'pdf' => (LucideIcons.fileText, Colors.red),
      'doc' || 'docx' => (LucideIcons.fileText, Colors.blue),
      'xls' || 'xlsx' => (LucideIcons.fileSpreadsheet, Colors.green),
      'ppt' || 'pptx' => (LucideIcons.fileText, Colors.orange),
      'jpg' || 'jpeg' || 'png' || 'gif' || 'webp' || 'svg' => (
          LucideIcons.image,
          Colors.purple
        ),
      'mp4' || 'mkv' || 'mov' || 'avi' => (LucideIcons.video, Colors.redAccent),
      'mp3' || 'wav' || 'flac' || 'm4a' => (LucideIcons.music, Colors.teal),
      'zip' || 'rar' || '7z' || 'tar' || 'gz' => (
          LucideIcons.archive,
          Colors.amber
        ),
      'dart' ||
      'js' ||
      'ts' ||
      'py' ||
      'java' ||
      'c' ||
      'cpp' ||
      'html' ||
      'css' =>
        (LucideIcons.code, Colors.blueGrey),
      'txt' || 'md' => (LucideIcons.fileText, Colors.grey),
      'apk' || 'exe' || 'dmg' => (LucideIcons.appWindow, Colors.indigo),
      _ => (LucideIcons.file, primary),
    };
  }
}
