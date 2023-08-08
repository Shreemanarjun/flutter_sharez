import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';

import '../../helpers/pump_app.dart';

final testAsyncValuePod = FutureProvider.autoDispose<String>((ref) async {
  return "Hi";
});

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Check AsyncValue Easy when', () {
    testWidgets(
      'check on data Placeholder should be rendered',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Placeholder), findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default error should be rendered',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [testAsyncValuePod.overrideWith((ref) => throw "")],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultErrorWidget), findsOneWidget);
      },
    );
    testWidgets(
      'check on error custom error should be rendered',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith((ref) => throw "custom error")
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    errorWidget: (error, stackTrace) {
                      return Text(error.toString());
                    },
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text("custom error"), findsOneWidget);
      },
    );

    testWidgets(
      'check custom loading widget should be rendered',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    loadingWidget: () {
                      return const Text('Loading');
                    },
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Loading'), findsOneWidget);
      },
    );
    testWidgets(
      'check isLinear  should render error in row and text should be Try again letter when onRetry is not passed ',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith((ref) => throw "Error"),
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    isLinear: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Row), findsOneWidget);
        expect(find.text('Try Again later.'), findsOneWidget);
      },
    );
    testWidgets(
      'check isLinear should render error in row ',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith((ref) => throw "Error"),
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    isLinear: true,
                    onRetry: () => ref.invalidate(testAsyncValuePod),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Row), findsOneWidget);
        expect(
            find.widgetWithText(ElevatedButton, 'Try again '), findsOneWidget);
      },
    );
    testWidgets(
      'check isLinear should render error in row ',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith((ref) => throw "Error"),
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    onRetry: () => ref.invalidate(testAsyncValuePod),
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Column), findsOneWidget);
        expect(
            find.widgetWithText(ElevatedButton, 'Try again '), findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error connection timeout should be rendered and with connection time out text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Connection Timeout Error'), findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error sendTimeout should be rendered and with connection sendTimeout text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.sendTimeout,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(
            find.text(
                'Unable to connect to the server.Please try again later.'),
            findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error receiveTimeout should be rendered and with connection receiveTimeout text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.receiveTimeout,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Check you internet connection reliability.'),
            findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error badCertificate should be rendered and with connection badCertificate text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.badCertificate,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Please update your OS or add certificate.'),
            findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error badResponse should be rendered and with connection badResponse text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.badResponse,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Something went wrong.Please try again later.'),
            findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error cancel should be rendered and with connection cancel text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.cancel,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Request Cancelled'), findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error connectionError should be rendered and with connectionError text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.connectionError,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Unable to connect to server.Please try again later.'),
            findsOneWidget);
      },
    );
    testWidgets(
      'check on error Default Dio Error unknown should be rendered and with unknown text',
      (tester) async {
        await tester.pumpApp(
          ProviderScope(
            overrides: [
              testAsyncValuePod.overrideWith(
                (ref) => throw DioException(
                  type: DioExceptionType.unknown,
                  requestOptions: RequestOptions(
                    path: "/",
                  ),
                ),
              )
            ],
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final valueAsync = ref.watch(testAsyncValuePod);
                  return valueAsync.easyWhen(
                    data: (data) => const Placeholder(),
                    includedefaultDioErrorMessage: true,
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(DefaultDioErrorWidget), findsOneWidget);
        expect(find.text('Please check your internet connection.'),
            findsOneWidget);
      },
    );
  });
}
