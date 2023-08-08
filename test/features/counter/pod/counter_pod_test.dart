import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sharez/features/counter/counter.dart';
import 'package:riverpod_test/riverpod_test.dart';

abstract class MyAbstract {}

class AbstractwithconstConstructor implements MyAbstract {
  const AbstractwithconstConstructor();
}

class NOConstAbstract implements MyAbstract {}

void main() {
  group('CounterNotifier', () {
    testNotifier<CounterNotifier, int>(
      'initial state is 0',
      provider: counterPod,
      expect: () => [0],
      emitBuildStates: true,
    );
    testNotifier<CounterNotifier, int>(
      'initial state is 1',
      overrides: [intialCounterValuePod.overrideWithValue(1)],
      provider: counterPod,
      expect: () => [1],
      emitBuildStates: true,
    );
    testNotifier<CounterNotifier, int>(
      'emits [0] on start then [1] when increment is called',
      provider: counterPod,
      expect: () => [0, 1],
      emitBuildStates: true,
      act: (notifier) => notifier.increment(),
    );
    testNotifier<CounterNotifier, int>(
      'emits [1] when increment is called',
      provider: counterPod,
      expect: () => [1],
      act: (notifier) => notifier.increment(),
    );
    testNotifier<CounterNotifier, int>(
      'emits [0] on start then [-1] when increment is called',
      provider: counterPod,
      expect: () => [0, -1],
      emitBuildStates: true,
      act: (notifier) => notifier.decrement(),
    );
    testNotifier<CounterNotifier, int>(
      'emits [-1] when decrement is called',
      provider: counterPod,
      expect: () => [-1],
      act: (notifier) => notifier.decrement(),
    );
    testNotifier<CounterNotifier, int>(
      'expect [2] when increment is called twice',
      provider: counterPod,
      act: (notifier) => notifier
        ..increment()
        ..increment(),
      skip: 1,
      expect: () => [2],
    );

    test('with const', () {
      expect(
        const AbstractwithconstConstructor(),
        const AbstractwithconstConstructor(),
      );
    });
    test('without const', () {
      expect(
        NOConstAbstract(),
        isNot(equals(NOConstAbstract())),
      );
    });
  });
}
