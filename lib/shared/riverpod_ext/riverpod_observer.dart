import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

// coverage:ignore-file
base class MyObserverLogger extends ProviderObserver {
  MyObserverLogger({required this.talker});
  final Talker talker;

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final provider = context.provider;
    final name = provider.name != null
        ? '${provider.name} of Type `${provider.runtimeType}`'
        : {provider.runtimeType};
    if (newValue is AsyncValue?) {
      final previousAsyncValue = previousValue;
      if (previousAsyncValue is AsyncValue?) {
        final newv = newValue?.value;
        final previousv = previousAsyncValue?.value;
        talker.log('Provider is: '
            '$name \n'
            'previous value: $previousv \n'
            'new value: $newv');
      }
    } else {
      talker.log('Provider is: '
          '$name \n'
          'previous value: $previousValue\n'
          'new value: $newValue');
    }
  }
}
