import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SenderModel Tests', () {
    test('fromMap provides defaults for missing keys', () {
      final map = {'ip': '1.1.1.1'}; // No port, No deviceName, etc.
      
      final model = SenderModel.fromMap(map);
      
      expect(model.ip, '1.1.1.1');
      expect(model.port, 0);
      expect(model.deviceName, '');
      expect(model.filesCount, 0);
    });

    test('toJson and fromJson work correctly', () {
      final model = SenderModel(
        ip: '192.168.1.5',
        port: 5050,
        filesCount: 10,
        host: 'host',
        deviceName: 'my-phone',
        deviceUUID: 'xyz',
        os: 'android',
        version: '11',
      );

      final jsonStr = model.toJson();
      final decoded = SenderModel.fromJson(jsonStr);

      expect(decoded, model);
      expect(decoded.port, 5050);
    });

    test('operator == works logically', () {
       final m1 = SenderModel(ip: '1', port: 1, filesCount: 1, host: 'h', deviceName: 'd', deviceUUID: 'u', os: 'o', version: 'v');
       final m2 = m1.copyWith();
       final m3 = m1.copyWith(ip: '2');
       
       expect(m1 == m2, true);
       expect(m1 == m3, false);
    });
  });
}
