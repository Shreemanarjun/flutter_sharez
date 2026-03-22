import 'package:flutter/material.dart';
import 'package:flutter_sharez/shared/widget/skeleton_file_loader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  group('SkeletonFileLoader Widget Tests', () {
    testWidgets('Renders multiple skeleton cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        ShadApp(
          home: Scaffold(
            body: const SkeletonFileLoader(),
          ),
        ),
      );

      // Verify that ShadCards are rendered (itemCount is 8)
      expect(find.byType(ShadCard), findsWidgets);
      
      // Check for presence of skeleton bits (Container with muted color)
      // Since they correspond to private classes, we check for presence via generic types.
      final containers = find.descendant(
        of: find.byType(Row),
        matching: find.byType(Container),
      );
      expect(containers, findsAtLeastNWidgets(24)); // 3 per row * 8 rows
    });
  });
}
