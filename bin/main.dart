import 'dart:io';
import 'package:systemdashboardcli/server.dart';

/// Main entry point
void main() async {
  print('🚀 Starting System Dashboard...\n');
  await startServer();
  _openBrowser();
  print('\n💡 Press Ctrl+C to stop the server');
}

void _openBrowser() {
  final url = 'http://localhost:4040';

  try {
    if (Platform.isMacOS) {
      // macOS
      Process.run('open', [url]);
    } else if (Platform.isWindows) {
      // Windows
      Process.run('start', [url], runInShell: true);
    } else {
      // Linux
      Process.run('xdg-open', [url]);
    }
    print('🌍 Opening browser at $url');
  } catch (e) {
    print('⚠️  Could not auto-open browser. Please visit: $url');
  }
}
