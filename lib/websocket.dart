import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:systemdashboardcli/src/rust/api/simple.dart' as rust_api;

/// Stores all active WebSocket connections
final clients = <WebSocket>{};

/// When a client connects to /ws, this upgrades the HTTP request to WebSocket
void handleWebSocket(HttpRequest request) async {
  // Upgrade the HTTP connection to WebSocket protocol
  final socket = await WebSocketTransformer.upgrade(request);
  clients.add(socket);
  print('✅ Client connected. Total clients: ${clients.length}');
  socket.done.then((_) {
    clients.remove(socket);
    print('❌ Client disconnected. Total clients: ${clients.length}');
  });
}

Future<Map<String, dynamic>> getSystemStats() async {
  final stats = await rust_api.getSystemStats();

  return {
    // Memory stats (converted to MB for easier reading)
    'totalMemoryMB': (stats.totalMemory.toInt() / 1024 / 1024).toStringAsFixed(
      1,
    ),
    'freeMemoryMB': (stats.freeMemory.toInt() / 1024 / 1024).toStringAsFixed(1),
    'usedMemoryMB': (stats.usedMemory.toInt() / 1024 / 1024).toStringAsFixed(1),
    'totalSwapMB': (stats.totalSwap.toInt() / 1024 / 1024).toStringAsFixed(1),
    'usedSwapMB': (stats.usedSwap.toInt() / 1024 / 1024).toStringAsFixed(1),

    // Memory usage percentage
    'memoryUsagePercent': stats.memoryUsagePercent.toStringAsFixed(1),

    // Raw bytes
    'totalMemory': stats.totalMemory.toString(),
    'freeMemory': stats.freeMemory.toString(),
    'usedMemory': stats.usedMemory.toString(),

    // Cpu Usage
    'cpuUsage': stats.cpuUsage.toStringAsFixed(1),

    // System Information
    'systemName': stats.systemName ?? 'Unknown',
    'osVersion': stats.osVersion ?? 'Unknown',
    'hostName': stats.hostName ?? 'Unknown',
    'kernelVersion': stats.kernelVersion ?? 'Unknown',

    // Timestamp
    'timestamp': DateTime.now().toIso8601String(),
  };
}

/// Broadcasts system st to all connected clients every second
void startStatsBroadcast() {
  Timer.periodic(const Duration(seconds: 1), (_) async {
    final data = jsonEncode(await getSystemStats());
    for (final client in clients) {
      try {
        client.add(data);
      } catch (e) {
        print('Error sending to client: $e');
      }
    }
  });
}
