🌐 System Stats Dashboard (Rust + Dart + WebSockets)

A real-time system monitoring dashboard powered by Rust (system metrics engine) and a Dart CLI server, with live updates streamed to a browser via WebSockets.

This project explores cross-language architecture, where each language is used for what it does best:

🦀 Rust → low-level system metrics

🟦 Dart → networking + WebSocket server

🌐 Web → real-time visualization

🚀 Demo

Live system stats updating in real-time via WebSockets

✨ Features

⚡ Real-time system monitoring (CPU, Memory)

🔌 WebSocket-based live updates

🦀 Rust-powered system metrics (via sysinfo)

🔗 Seamless Rust ↔ Dart interop using flutter_rust_bridge

🖥️ Cross-platform (macOS, Linux, Windows)

🧩 Modular architecture (separation of concerns)

🧠 Architecture
Rust (sysinfo)
   ↓
flutter_rust_bridge (FFI)
   ↓
Dart CLI Server
   ↓
WebSocket
   ↓
Browser Dashboard
Why this design?

Rust provides efficient, low-level access to system resources

Dart handles asynchronous networking and WebSockets

The frontend remains decoupled and flexible

📸 Screenshots
<img width="2880" height="1344" alt="dashboard" src="https://github.com/user-attachments/assets/79f478fa-9966-49b1-bf31-e5023a04284a" />
🛠️ Tech Stack
Layer	Technology
System Layer	🦀 Rust + sysinfo
Bridge	flutter_rust_bridge
Backend	Dart CLI (HttpServer + WebSocket)
Frontend	Flutter Web / Browser
📦 Installation
1. Clone the repository
git clone https://github.com/yourusername/system-stats-dashboard.git
cd system-stats-dashboard
2. Install dependencies
Dart
dart pub get
Rust

Make sure you have Rust installed:

rustc --version

If not, install via:

https://rustup.rs/

3. Build the Rust library
cd rustcode/stats_engine
cargo build

This generates the native library used by Dart.

4. Generate FFI bindings

Run from project root:

flutter_rust_bridge_codegen generate \
--rust-root rustcode/stats_engine \
--rust-input crate:: \
--dart-output lib/rust/bridge_generated.dart
5. Run the CLI server
dart run bin/server.dart
6. Open the dashboard

Open your browser:

http://localhost:8080
📡 WebSocket API

The server streams JSON data every second:

{
  "totalMemory": 16384,
  "usedMemory": 8240,
  "freeMemory": 8144,
  "memoryUsagePercent": 50.3,
  "cpuUsage": 12.7,
  "timestamp": "2026-03-17T12:00:00Z"
}
📁 Project Structure
systemdashboardcli/
│
├── lib/
│   └── rust/
│       └── bridge_generated.dart   # Generated Dart bindings
│
├── rustcode/
│   └── stats_engine/
│       ├── src/
│       │   ├── lib.rs              # Rust API
│       │   └── frb_generated.rs    # Generated Rust bindings
│       └── Cargo.toml
│
├── bin/
│   └── server.dart                # CLI WebSocket server
│
└── web/
    └── dashboard/                 # Frontend (optional)
🔍 Key Concepts
🦀 Rust as a Metrics Engine

Using the sysinfo crate, Rust collects:

CPU usage

Memory stats

System-level metrics

🔗 FFI via flutter_rust_bridge

Instead of writing manual FFI bindings, flutter_rust_bridge:

Generates Rust + Dart bindings automatically

Handles serialization/deserialization

Provides async-safe APIs

🌐 WebSocket Streaming

The Dart server:

Collects stats from Rust

Broadcasts them to all connected clients

Enables real-time UI updates

⚡ Future Improvements

📊 Disk usage stats

🌍 Network I/O monitoring

🔄 Real-time streaming from Rust (no polling)

🧠 Process-level monitoring (like htop)

📱 Native Flutter dashboard

🤝 Contributing

Contributions are welcome!

Feel free to:

Open issues

Suggest improvements

Submit PRs

📄 License

MIT License

🙌 Acknowledgements

Rust ecosystem

Dart & Flutter team

flutter_rust_bridge contributors

💡 Author

Built by John Audu

