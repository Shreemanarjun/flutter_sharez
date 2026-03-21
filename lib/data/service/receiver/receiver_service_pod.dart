import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/service/receiver/receiver_service.dart';

final receiverServicePod = Provider.autoDispose<ReceiverService>((ref) {
  return ReceiverService();
});
