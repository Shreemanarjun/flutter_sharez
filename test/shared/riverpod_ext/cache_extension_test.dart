import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_sharez/shared/riverpod_ext/cache_extensions.dart';

final cacheStateProvider = StateProvider.autoDispose<int>((ref) {
  ref.cacheFor(const Duration(seconds: 3));
  return 0;
});

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Page2(),
              ));
            },
            child: const Text('Page A'),
          )
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final counter = ref.watch(cacheStateProvider);
              return Text(counter.toString());
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(cacheStateProvider.notifier)
                      .update((state) => state + 1);
                },
                child: child,
              );
            },
            child: const Text('Add'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(cacheStateProvider.notifier)
                      .update((state) => state - 1);
                },
                child: child,
              );
            },
            child: const Text('Subtract'),
          )
        ],
      ),
    );
  }
}

// Mock the KeepAliveLink class
class MockKeepAliveLink extends Mock implements KeepAliveLink {}

final autoRefreshProvider = StateProvider.autoDispose<int>((ref) {
  ref.autoRefresh(duration: const Duration(seconds: 5));
  return 5;
});

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final autocount = ref.watch(autoRefreshProvider);
              return Text(autocount.toString());
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(autoRefreshProvider.notifier)
                      .update((state) => state + 1);
                },
                child: child,
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

Future<void> main() async {
  group('Check riverpod extension', () {
    testWidgets(
      "Check cache",
      (tester) async {
        final providercontainer = ProviderContainer();
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: providercontainer,
            child: const MaterialApp(
              home: Page1(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Page A'), findsOneWidget);
        await tester.tap(find.text('Page A'));
        await tester.pumpAndSettle();
        expect(find.byType(Page2), findsOneWidget);
        expect(find.text('0'), findsOneWidget);
        await tester.tap(find.text('Add'));
        await tester.pumpAndSettle();
        expect(find.text('1'), findsOneWidget);

        await tester.runAsync(() async {
          await tester.pageBack();
          await tester.pumpAndSettle(const Duration(seconds: 4));
          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.text('Page A'));
          await tester.pumpAndSettle();
          expect(find.byType(Page2), findsOneWidget);
          expect(find.text('0'), findsOneWidget);
          expect(find.text('1'), findsNothing);
        });
        providercontainer.invalidate(cacheStateProvider);
        await tester.pumpAndSettle();
        expect(find.text('0'), findsOneWidget);
        expect(find.text('1'), findsNothing);
      },
    );

    testWidgets(
      "Check auto refresh",
      (tester) async {
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Page3(),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
        await tester.tap(find.text('Add'));
        await tester.pumpAndSettle();
        expect(find.text('6'), findsOneWidget);

        await tester.runAsync(() async {
          await tester.pumpAndSettle(const Duration(seconds: 5));
          expect(find.text('5'), findsOneWidget);
          expect(find.text('6'), findsNothing);
        });
      },
    );
  });
}
