import 'package:flutter/material.dart';
import 'package:flutter_sharez/shared/widget/file_icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  group('FileIcon Widget Tests', () {
    testWidgets('Displays PDF icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileIcon(fileName: 'test.pdf'),
          ),
        ),
      );

      final iconFinder = find.byIcon(LucideIcons.fileText);
      expect(iconFinder, findsOneWidget);
      
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, Colors.red);
    });

    testWidgets('Displays Image icon for PNG', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileIcon(fileName: 'photo.png'),
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.image), findsOneWidget);
    });

    testWidgets('Fallback to generic file icon for unknown extension', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileIcon(fileName: 'unknown_file.xyz'),
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.file), findsOneWidget);
    });

    testWidgets('Case-insensitive extension handling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileIcon(fileName: 'DOCUMENT.PDF'),
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.fileText), findsOneWidget);
    });
  });
}
