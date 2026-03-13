import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:systemdashboardcli/src/rust/frb_generated.dart';
import 'websocket.dart';

/// serves both WebSocket and static files
Future<void> startServer() async {
  await RustLib.init();
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);
  print('🌐 Dashboard running at http://localhost:4040');
  print('📊 WebSocket endpoint: ws://localhost:4040/ws');

  //WebSocket broadcasting
  startStatsBroadcast();

  await for (HttpRequest request in server) {
    // WebSocket endpoint
    if (request.uri.path == '/ws') {
      handleWebSocket(request);
      continue;
    }
    // Serve Flutter Web files
    final requestedPath = request.uri.path == '/'
        ? 'index.html'
        : request.uri.path.substring(1);
    final filePath = p.join('web', requestedPath);
    final file = File(filePath);
    if (await file.exists()) {
      request.response.headers.contentType = ContentType.parse(
        _getMimeType(filePath),
      );
      await request.response.addStream(file.openRead());
      await request.response.close();
    } else {
      request.response.statusCode = HttpStatus.notFound;
      await request.response.close();
      print('File not found: $filePath');
    }
  }
}

String _getMimeType(String path) {
  if (path.endsWith('.js')) return 'application/javascript';
  if (path.endsWith('.html')) return 'text/html';
  if (path.endsWith('.css')) return 'text/css';
  if (path.endsWith('.json')) return 'application/json';
  if (path.endsWith('.wasm')) return 'application/wasm';
  if (path.endsWith('.ico')) return 'image/x-icon';
  return 'application/octet-stream';
}
