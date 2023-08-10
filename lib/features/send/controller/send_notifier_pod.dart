import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/send/controller/notifier/send_state_notifier.dart';
import 'package:flutter_sharez/features/send/state/send_state.dart';

final sendStateNotifierPod =
    AsyncNotifierProvider.autoDispose<SendStateNotifier, SendState>(
  SendStateNotifier.new,
  name: 'sendStateNotifierPod',
);
