import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/local_storage/app_storage.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/service/sender/sender_service.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:file_picker/file_picker.dart';

class MockAppStorage extends Mock implements AppStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel('fr.skyost.bonsoir');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(methodChannel, (MethodCall methodCall) async {
    return null;
  });

  group('P2P Send-Receive Integration Test', () {
    late ProviderContainer container;
    late MockAppStorage mockAppStorage;
    late SenderService senderService;
    late Ref ref;
    late File tempFile;
    
    setUpAll(() {
       HttpOverrides.global = null; // Ensure no proxy/network overrides
    });

    setUp(() async {
      mockAppStorage = MockAppStorage();
      
      tempFile = File('${Directory.systemTemp.path}/integration_test_file.txt');
      await tempFile.writeAsString("Integrate me!");

      container = ProviderContainer(
        overrides: [
          appStorageProvider.overrideWithValue(mockAppStorage),
          paltformFilesPod.overrideWith((ref) => [
            PlatformFile(
              name: 'integration_test_file.txt',
              size: tempFile.lengthSync(),
              path: tempFile.path,
            ),
          ]),
        ],
      );
      
      final dummyProvider = Provider((r) {
        ref = r;
        return null;
      });
      container.read(dummyProvider);

      when(() => mockAppStorage.get(key: any(named: 'key'))).thenReturn(null);
      when(() => mockAppStorage.put(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});
      
      senderService = SenderService(port: 0, ref: ref);
    });

    tearDown(() async {
      await senderService.stopServer();
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      container.dispose();
    });

    test('Flow: Sender starts -> Receiver connects -> JSON list correct', () async {
      final startResult = await senderService.startServer(
        onCheckServerCalled: (model) async {
          return true;
        },
      );
      
      expect(startResult.isSuccess(), true);
      final senderInfo = senderService.getServerInfo();
      final port = senderInfo.port;
      final ip = '127.0.0.1';

      final client = HttpClient();

      try {
        final handshakeRequest = await client.post(ip, port, '/checkServer');
        handshakeRequest.headers.set('content-type', 'application/json');
        handshakeRequest.add(utf8.encode(jsonEncode({
          'ip': '127.0.0.1',
          'port': 1234,
          'host': 'receiver-host',
          'os': 'ios',
          'version': '1.0.0',
          'deviceUUID': 'receiver-uuid',
        })));
        final handshakeResponse = await handshakeRequest.close();
        final handshakeBody = await handshakeResponse.transform(utf8.decoder).join();
        
        expect(handshakeResponse.statusCode, 200, reason: "Handshake failed: $handshakeBody");
        expect(handshakeBody, contains('Accepted'));

        final fileListRequest = await client.get(ip, port, '/filepath');
        final fileListResponse = await fileListRequest.close();
        final fileListBody = await fileListResponse.transform(utf8.decoder).join();
        
        expect(fileListResponse.statusCode, 200, reason: "File list failed: $fileListBody");
        final decodedBody = jsonDecode(fileListBody);
        
        expect(decodedBody['paths'], isA<List>());
        expect(decodedBody['paths'].length, 1);

        final encodedName = Uri.encodeComponent('integration_test_file.txt');
        final downloadRequest = await client.get(ip, port, '/files/$encodedName');
        final downloadResponse = await downloadRequest.close();
        final downloadBody = await downloadResponse.transform(utf8.decoder).join();
        
        expect(downloadResponse.statusCode, 200);
        expect(downloadBody, "Integrate me!");
      } finally {
        client.close();
      }
    });
  });
}
