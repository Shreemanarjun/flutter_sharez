import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

// coverage:ignore-file
class MyObserverLogger<T> extends ProviderObserver {
  MyObserverLogger({required this.talker}) : super();
  final Talker talker;

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final name = provider.name != null
        ? '${provider.name} of Type `${provider.runtimeType}`'
        : {provider.runtimeType};
    if (newValue is StateController) {
      final newv = newValue.state;
      final perviousv = (previousValue as StateController?)?.state;
      talker.log('Provider is: '
          '$name \n'
          'previous value: $perviousv \n'
          'new value: $newv');
    } else if ((newValue is AsyncValue?) && (previousValue is AsyncValue?)) {
      final previousAsyncValue = previousValue;
      if (previousAsyncValue != null) {
        final newv = newValue?.valueOrNull;
        final previousv = previousAsyncValue.valueOrNull;
        talker.log('Provider is: '
            '$name \n'
            'previous value: $previousv \n'
            'new value: $newv');
      } else {
        talker.log('Provider is: '
            '$name \n'
            'previous value: null \n'
            'new value: ${newValue?.valueOrNull}');
      }
    } else {
      talker.log('Provider is: '
          '$name \n'
          'previous value: $previousValue\n'
          'new value: $newValue');
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
