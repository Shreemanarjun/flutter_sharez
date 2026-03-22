import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/features/receive/controller/receive_pods.dart';
import 'package:flutter_sharez/features/receive/view/receive_state_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';

class MockReceiverServerListNotifier extends ReceiverServerListNotifier {
  final List<SenderModel>? initialData;
  final bool isLoading;
  MockReceiverServerListNotifier({this.initialData, this.isLoading = false});

  @override
  Stream<List<SenderModel>> build() async* {
    if (isLoading) {
       await Completer().future;
    } else {
      yield initialData ?? [];
    }
  }
}

void main() {
  group('ReceiveStatePage UX Tests', () {
    testWidgets('Loading state shows scanning text', (WidgetTester tester) async {
       final t = AppLocale.en.buildSync();
       await tester.pumpWidget(
          ProviderScope(
            overrides: [
              oKServersListProvider.overrideWith(() => MockReceiverServerListNotifier(isLoading: true)),
              translationsPod.overrideWith((ref) => t),
            ],
            child: ShadApp(
              home: const ReceiveStatePage(),
            ),
          ),
        );

        expect(find.text(t.scanningNetwork), findsOneWidget);
        expect(find.text("Looking for nearby devices..."), findsOneWidget);
    });

    testWidgets('Empty state shows no devices text', (WidgetTester tester) async {
       final t = AppLocale.en.buildSync();
       await tester.pumpWidget(
        ProviderScope(
          overrides: [
             oKServersListProvider.overrideWith(() => MockReceiverServerListNotifier(initialData: [])),
             translationsPod.overrideWith((ref) => t),
          ],
          child: ShadApp(
            home: const ReceiveStatePage(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text(t.noDevicesinNetwork), findsOneWidget);
    });
  });
}
