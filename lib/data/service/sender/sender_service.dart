import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/core/local_storage/app_storage_pod.dart';
import 'package:flutter_sharez/data/model/file_model.dart';
import 'package:flutter_sharez/data/model/range_header.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/data/model/sender_model.dart';
import 'package:flutter_sharez/data/model/server_info.dart';
import 'package:flutter_sharez/data/service/sender/sender_service_pod.dart';
import 'package:flutter_sharez/data/service/sender/transfer_progress_pod.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:flutter_sharez/shared/helper/file_list_html_render.dart';
import 'package:flutter_sharez/shared/helper/network_helper.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [SenderService] manages the local HTTP server and mDNS broadcasting
/// for sharing files from this device to others in the local network.
///
/// It handles:
/// - HTTP server setup using `shelf`.
/// - File serving with support for range headers (for resumable downloads).
/// - WebSocket updates to notify connected clients of file list changes.
/// - mDNS broadcasting via `Bonsoir` so other devices can discover this sender.
class SenderService {
  /// The port on which the HTTP server will run.
  final int port;

  /// Riverpod Ref to access other providers (e.g., file list updates).
  final Ref ref;

  /// mDNS broadcast instance.
  BonsoirBroadcast? _broadcast;

  /// List of connected WebSocket clients to notify of updates.
  final List<WebSocketChannel> _webSocketClients = [];

  /// Cached list of local network IPs.
  List<String> _allIps = [];

  /// The human-readable name of this device.
  late String _deviceName;

  /// A persistent unique identifier for this device.
  late String _deviceUUID;

  /// Local cache of currently selected files for sharing.
  List<PlatformFile> _currentFiles = [];

  SenderService({
    required this.port,
    required this.ref,
  }) {
    _deviceName = _getDeviceName();
    _deviceUUID = _getDeviceUUID();

    // Initialize files and listen for updates
    _currentFiles = ref.read(paltformFilesPod);
    ref.listen(paltformFilesPod, (previous, next) {
      _currentFiles = next;
      talker.debug(
          "Files updated, notifying ${_webSocketClients.length} sessions");
      for (var client in _webSocketClients) {
        try {
          client.sink.add(jsonEncode({'type': 'update'}));
        } catch (e) {
          talker.error("Failed to notify session: $e");
        }
      }
    });
  }

  /// The active HTTP server instance.
  HttpServer? server;

  /// Retrieves or generates a persistent device UUID.
  String _getDeviceUUID() {
    final storage = ref.read(appStorageProvider);
    var uuid = storage.get(key: 'device_uuid');
    if (uuid == null) {
      uuid = const Uuid().v4();
      storage.put(key: 'device_uuid', value: uuid);
    }
    return uuid;
  }

  /// Retrieves or generates a persistent device name.
  String _getDeviceName() {
    final storage = ref.read(appStorageProvider);
    var name = storage.get(key: 'device_name');
    if (name == null) {
      final random =
          DateTime.now().millisecondsSinceEpoch.toString().substring(9);
      name = "${Platform.operatingSystem}-$random";
      storage.put(key: 'device_name', value: name);
    }
    return name;
  }

  /// Starts mDNS broadcasting using the `_sharez._tcp` service type.
  Future<void> _startBroadcasting(String ip, int port) async {
    try {
      BonsoirService service = BonsoirService(
        name: _deviceName,
        type: '_sharez._tcp',
        port: port,
        attributes: {
          'ip': ip,
          'uuid': _deviceUUID,
        },
      );

      _broadcast = BonsoirBroadcast(service: service);
      await _broadcast!.initialize();
      await _broadcast!.start();
      talker.info("mDNS Broadcasting started for $_deviceName ($_deviceUUID)");
    } catch (e) {
      talker.error("mDNS Error: $e");
    }
  }

  /// Configures and starts the HTTP server.
  ///
  /// [onCheckServerCalled] is a callback invoked when another device
  /// attempts to connect, allowing the UI to show a confirmation dialog.
  Future<Result<bool, BaseException>> startServer({
    required Future<bool> Function(ReceiverModel receiverModel)
        onCheckServerCalled,
  }) async {
    try {
      final router = Router();

      // WS Endpoint: Used by receivers to know when the file list is updated.
      router.get('/ws',
          webSocketHandler((WebSocketChannel webSocket, String? protocol) {
        _webSocketClients.add(webSocket);
        webSocket.stream.listen(null, onDone: () {
          _webSocketClients.remove(webSocket);
        });
      }));

      // JSON metadata endpoint: Returns the list of available files and their download links.
      router.get('/filepath', (Request request) {
        final filejson = _currentFiles.map((e) {
          final encode = Uri.encodeFull(e.name);
          final map = {
            'file': FileModel(
                    name: e.name, size: e.size, fileExt: e.extension ?? "")
                .toMap(),
            'link': "/files/$encode",
          };
          return map;
        }).toList();

        return Response.ok(
          jsonEncode({'paths': filejson}),
          headers: {'content-type': 'application/json'},
        );
      });

      // Browser-friendly UI: Allows downloading files via a simple HTML page.
      router.get('/web', (Request request) {
        final html =
            htmlFiles(files: _currentFiles, serverInfo: getServerInfo());
        return Response.ok(html, headers: {'content-type': 'text/html'});
      });

      // File download endpoint: Handles chunked and resumable file streaming.
      router.all('/files/<id>', (Request request, String id) async {
        final decodedID = Uri.decodeComponent(id);
        final filenamelist = _currentFiles.map((e) => e.name).toList();
        final isFileAvailable = filenamelist.contains(decodedID);

        if (!isFileAvailable) {
          return Response.notFound(jsonEncode({'message': 'File Not Found'}),
              headers: {'content-type': 'application/json'});
        }

        final fileIndex = filenamelist.indexOf(decodedID);
        final currentFile = _currentFiles[fileIndex];
        final file = File(currentFile.path!);
        final fileSize = currentFile.size;

        // Support for HEAD requests (often used to check file size before download).
        if (request.method == 'HEAD') {
          return Response.ok(null, headers: {
            'content-length': fileSize.toString(),
            'accept-ranges': 'bytes',
          });
        }

        if (request.method == 'GET') {
          final rangeHeader = request.headers['range'];
          final range = parseRangeHeader(rangeHeader, fileSize);
          final fileName = p.basename(currentFile.path!);
          final encodedFileName = Uri.encodeComponent(fileName);

          final responseHeaders = {
            'Content-Disposition': 'attachment; filename=$encodedFileName',
            'accept-ranges': 'bytes',
          };

          // Full file download
          if (range.start == 0 && range.end == null) {
            responseHeaders['content-length'] = fileSize.toString();
            final stream = file.openRead().map((data) {
              ref
                  .read(uploadProgressPod.notifier)
                  .updateProgress(currentFile.name, fileSize, data.length);
              return data;
            }).handleError((e) {
              ref
                  .read(uploadProgressPod.notifier)
                  .removeTransfer(currentFile.name);
            });
            return Response.ok(stream, headers: responseHeaders);
          } else {
            // Partial content download (Resuming or multi-part download)
            final start = range.start;
            final end = range.end ?? fileSize - 1;
            final contentLength = end - start + 1;

            if (end >= fileSize) {
              return Response(416,
                  headers: {'Content-Range': 'bytes */$fileSize'});
            }

            responseHeaders['Content-Range'] = 'bytes $start-$end/$fileSize';
            responseHeaders['content-length'] = contentLength.toString();

            final stream = file.openRead(start, end + 1).map((data) {
              ref
                  .read(uploadProgressPod.notifier)
                  .updateProgress(currentFile.name, fileSize, data.length);
              return data;
            }).handleError((e) {
              ref
                  .read(uploadProgressPod.notifier)
                  .removeTransfer(currentFile.name);
            });

            return Response(HttpStatus.partialContent,
                body: stream, headers: responseHeaders);
          }
        }

        return Response.notFound('Method Not Allowed');
      });

      // Server identity endpoint: Returns info about this device.
      router.get('/server', (Request request) {
        return Response.ok(
          jsonEncode(SenderModel(
            ip: getServerInfo().ip,
            port: server!.port,
            filesCount: _currentFiles.length,
            host: Platform.localHostname,
            deviceName: _deviceName,
            deviceUUID: _deviceUUID,
            os: Platform.operatingSystem,
            version: Platform.operatingSystemVersion,
          ).toMap()),
          headers: {'content-type': 'application/json'},
        );
      });

      // Connection verification endpoint: Called by receivers to request access.
      router.post('/checkServer', (Request request) async {
        final payload = await request.readAsString();
        final body = jsonDecode(payload);

        if (body is Map<String, dynamic>) {
          try {
            final model = ReceiverModelMapper.fromMap(body);
            final result = await onCheckServerCalled(model);
            if (result) {
              return Response.ok(
                jsonEncode({'message': 'Accepted', 'token': 'token'}),
                headers: {'content-type': 'application/json'},
              );
            } else {
              return Response.ok(
                jsonEncode({'message': 'Rejected'}),
                headers: {'content-type': 'application/json'},
              );
            }
          } catch (e) {
            return Response.badRequest(
                body: jsonEncode({'message': 'Invalid Request'}),
                headers: {'content-type': 'application/json'});
          }
        }
        return Response.badRequest();
      });

      // Parallelize IP finding and Server setup
      final results = await Future.wait([
        getAllIPs(),
        io.serve(router.call, InternetAddress.anyIPv4, port, shared: true),
      ]);

      final ipresult = results[0] as Result<List<String>, BaseException>;
      server = results[1] as HttpServer;

      final List<String> iplist = ipresult.when(
        (list) => list,
        (error) => [],
      );
      _allIps = iplist;

      final String? ip = iplist.isNotEmpty ? iplist.first : null;

      if (ip == null) {
        return Error(BaseException(message: "No IP found"));
      }

      talker.info('Server started at http://${server!.address.address}:$port');

      // Start broadcasting in background to avoid blocking the UI return
      unawaited(_startBroadcasting(ip, port));

      return const Success(true);
    } catch (e) {
      talker.error(e);
      await stopServer();
      return Error(BaseException(message: e.toString()));
    }
  }

  /// Returns a snapshot of current server metadata.
  ServerInfo getServerInfo() {
    return ServerInfo(
      ip: server?.address.address == '0.0.0.0'
          ? (_allIps.isNotEmpty ? _allIps.first : '0.0.0.0')
          : (server?.address.address ?? '0.0.0.0'),
      allIps: _allIps,
      port: server?.port ?? port,
      host: Platform.localHostname,
      deviceName: _deviceName,
      deviceUUID: _deviceUUID,
      os: Platform.operatingSystem,
      version: Platform.operatingSystemVersion,
    );
  }

  /// Stops both the HTTP server and the mDNS broadcast.
  Future<void> stopServer() async {
    try {
      if (_broadcast != null) {
        await _broadcast!.stop();
        _broadcast = null;
      }
      if (server != null) {
        await server!.close(force: true);
        server = null;
      }
      talker.log('Server Closed');
    } catch (e) {
      talker.error(e);
    }
  }
}
