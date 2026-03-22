import 'package:flutter_sharez/shared/helper/network_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkHelper Tests', () {
    test('getNetAddress should extract proper network address', () {
      final ipList = ['192.168.1.1', '10.0.0.15', '172.16.12.1'];
      final expectedNetAdd = ['192.168.1', '10.0.0', '172.16.12'];
      
      final result = getNetAddress(ipList);
      
      expect(result, expectedNetAdd);
    });

    test('getNetAddress should handle empty list', () {
      final result = getNetAddress([]);
      expect(result, []);
    });

    test('getNetAddress should handle single octet IPs (e.g., "127")', () {
      final result = getNetAddress(['127']);
      expect(result, ['']); // Splits by "." and removes last, leaves empty list then joins to ""
    });

    test('getNetAddress should handle malformed IPs or irregular segments', () {
      // "192.168.1" (only 3 segments) -> ["192", "168"] -> "192.168"
      final result = getNetAddress(['192.168.1']);
      expect(result, ['192.168']);
    });

    test('getNetAddress should handle trailing dots', () {
       // "192.168.1.1." -> ["192", "168", "1", "1", ""] 
       // remove last -> ["192", "168", "1", "1"] 
       // join -> "192.168.1.1"
      final result = getNetAddress(['192.168.1.1.']);
      expect(result, ['192.168.1.1']);
    });

    test('getNetAddress should handle segment-less non-dots', () {
      final result = getNetAddress(['localhost']);
      expect(result, ['']);
    });
  });
}
