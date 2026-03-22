import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReceiverModel Tests', () {
    test('toMap produces correct key-value pairs', () {
      final model = ReceiverModel(
        ip: '192.168.1.10',
        port: 8080,
        host: 'sender-host',
        os: 'android',
        version: '12',
        deviceUUID: 'uuid123',
      );

      final map = model.toMap();

      expect(map['ip'], '192.168.1.10');
      expect(map['port'], 8080);
      expect(map['host'], 'sender-host');
      expect(map['os'], 'android');
      expect(map['version'], '12');
      expect(map['deviceUUID'], 'uuid123');
    });

    test('fromMap produces correct model from valid map', () {
      final map = {
        'ip': '1.1.1.1',
        'port': 1234,
        'host': 'host',
        'os': 'ios',
        'version': '15',
        'deviceUUID': 'u',
      };

      final model = ReceiverModelMapper.fromMap(map);

      expect(model.ip, '1.1.1.1');
      expect(model.port, 1234);
    });

    test('Handles missing keys by throwing if required (by Mappable defaults)', () {
      final map = {'ip': '1.1.1.1'}; // Missing others
      expect(() => ReceiverModelMapper.fromMap(map), throwsA(isA<Exception>()));
    });
  });
}
