import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:system_info2/system_info2.dart';

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


Map<String, dynamic> getSystemStats() {
  final totalMem = SysInfo.getTotalPhysicalMemory();
  final freeMem = SysInfo.getFreePhysicalMemory();
  final usedMem = totalMem - freeMem;

  return {
    // Memory stats (converted to MB for easier reading)
    'totalMemoryMB': (totalMem / 1024 / 1024).toStringAsFixed(1),
    'freeMemoryMB': (freeMem / 1024 / 1024).toStringAsFixed(1),
    'usedMemoryMB': (usedMem / 1024 / 1024).toStringAsFixed(1),
    
    // Memory usage percentage
    'memoryUsagePercent': ((usedMem / totalMem) * 100).toStringAsFixed(1),
    
    // Raw bytes 
    'totalMemory': totalMem,
    'freeMemory': freeMem,
    'usedMemory': usedMem,
    
    // Timestamp 
    'timestamp': DateTime.now().toIso8601String(),
  };
}

/// Broadcasts system st to all connected clients every second
void startStatsBroadcast() {
  Timer.periodic(const Duration(seconds: 1), (_) {
    final data = jsonEncode(getSystemStats());
        for (final client in clients) {
      try {
        client.add(data);
      } catch (e) {
        print('Error sending to client: $e');
      }
    }
  });
}