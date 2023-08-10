import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/data/service/sender_service_pod.dart';
import 'package:flutter_sharez/shared/helper/file_list_html_render.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';
import 'package:path/path.dart' as p;
import 'package:alfred/alfred.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/file_model.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

class SenderService {
  final Alfred app;
  final int port;
  final AutoDisposeProviderRef<SenderService> ref;
  SenderService({
    required this.app,
    required this.port,
    required this.ref,
  });
  HttpServer? server;

  Future<Result<bool, BaseException>> startServer({
    required Future<bool> Function(ReceiverModel receiverModel)
        onCheckServerCalled,
  }) async {
    talker.log(port);
    try {
      app.get('/text', (req, res) => 'Text response');

      app.get('/json', (req, res) => {'json_response': true});

      app.get('/jsonExpressStyle', (req, res) {
        res.json({'type': 'traditional_json_response'});
      });
      app.get('/filepath', (request, res) async {
        final files = ref.read(paltformFilesPod);
        final filejson = files.map((e) {
          final encode = Uri.encodeFull(e.name);
          final map = {
            'file': FileModel(
                    name: e.name, size: e.size, fileExt: e.extension ?? "")
                .toMap(),
            'link': "${server!.address.address}:${server!.port}/files/$encode",
          };
          return map;
        }).toList();

        await res.json({'paths': filejson});
      });
      app.get('/filepath/web', (request, res) {
        final files = ref.read(paltformFilesPod);
        res.headers.contentType = ContentType.html;
        return htmlFiles(files: files, serverInfo: getServerInfo());
      });
      app.get('/files/:id', (req, res) async {
        final files = ref.read(paltformFilesPod);
        req.params['id'] != null;
        req.params['id'] is String;
        final id = req.params['id'] as String;
        final decodedID = utf8.decode(id.codeUnits);
        talker.debug(decodedID);
        final filenamelist = files.map((e) => e.name).toList();
        final isFileAvailable = filenamelist.contains(decodedID);
        if (isFileAvailable) {
          final fileindex = filenamelist.indexOf(decodedID);
          final currentFile = files[fileindex];
          final filebasename = p.basename(currentFile.path!);
          final encode = Uri.encodeFull(filebasename);
          res.setDownload(filename: encode);
          res.headers.contentLength = currentFile.size;
          res.headers.contentType = ContentType.binary;
          talker.log(res.headers);

          return File(currentFile.path!);
        } else {
          res.statusCode = 400;
          return {'message': 'File Not Found'};
        }
      });

      app.get('/html', (req, res) {
        res.headers.contentType = ContentType.html;
        return '<html><body><h1>Test HTMLs</h1></body></html>';
      });
      app.get('/server', (req, res) async {
        final server = app.server;
        final files = ref.read(paltformFilesPod);
        await res.json(
          SenderModel(
            ip: server!.address.address,
            port: server.port,
            filesCount: files.length,
            host: Platform.localHostname,
            os: Platform.operatingSystem,
            version: Platform.operatingSystemVersion,
          ).toMap(),
        );
      });

      app.post('/checkServer', (req, res) async {
        final body = await req.body; //JSON body
        body != null;
        if (body is Map<String, dynamic>) {
          final model = ReceiverModel.fromMap(body);
          final result = await onCheckServerCalled(model);
          talker.log('check_Server');
          if (result == true) {
            return {'message': 'Accepted', 'token': 'token'};
          } else {
            res.statusCode = 401;
            return {'message': 'Rejected'};
          }
        } else {
          res.statusCode = 400;
          return {'message': 'Check sender'};
        }
      });

      final defaultaddressResult = await getDefaultAddress();
      return defaultaddressResult.when(
        (ip) async {
          app.printRoutes();
          server = await app.listen(
            port,
            ip,
          );
          return const Success(true);
        },
        (e) async {
          talker.error(e.message);
          await stopServer();
          return Error(BaseException(message: e.message.toString()));
        },
      );
    } catch (e) {
      talker.error(e);
      await stopServer();

      return Error(BaseException(message: e.toString()));
    }
  }

  ServerInfo getServerInfo() {
    return ServerInfo(
      ip: server!.address.address,
      port: server?.port ?? 0,
      host: Platform.localHostname,
      os: Platform.operatingSystem,
      version: Platform.operatingSystemVersion,
    );
  }

  Future<void> stopServer() async {
    await app
        .close(force: true)
        .then((value) => talker.log('Server Closed $value'));
  }
}
