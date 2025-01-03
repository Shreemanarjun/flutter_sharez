import 'package:dart_mappable/dart_mappable.dart';
part 'receiver_model.mapper.dart';

@MappableClass()
class ReceiverModel with ReceiverModelMappable {
  final String ip;
  final int port;
  final String host;
  final String os;
  final String version;
  ReceiverModel({
    required this.ip,
    required this.port,
    required this.host,
    required this.os,
    required this.version,
  });
}
