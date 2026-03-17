# 🌐 System Stats Dashboard (Rust + Dart + WebSockets)

A **real-time system monitoring dashboard** powered by **Rust (system metrics engine)** and a **Dart CLI server**, with live updates streamed to a browser via **WebSockets**.

This project explores **cross-language architecture**, where each language is used for what it does best:

* 🦀 Rust → low-level system metrics
* 🟦 Dart → networking + WebSocket server
* 🌐 Web → real-time visualization


## ✨ Features

* ⚡ Real-time system monitoring (CPU, Memory)
* 🔌 WebSocket-based live updates
* 🦀 Rust-powered system metrics (via `sysinfo`)
* 🔗 Seamless Rust ↔ Dart interop using `flutter_rust_bridge`
* 🖥️ Cross-platform (macOS, Linux, Windows)
* 🧩 Clean and modular architecture

---

## 🧠 Architecture

```
Rust (sysinfo)
   ↓
flutter_rust_bridge (FFI)
   ↓
Dart CLI Server
   ↓
WebSocket
   ↓
Browser Dashboard
```

---

## 📸 Screenshots

![Dashboard Screenshot](https://github.com/user-attachments/assets/79f478fa-9966-49b1-bf31-e5023a04284a)

---

## 🛠️ Tech Stack

| Layer        | Technology                        |
| ------------ | --------------------------------- |
| System Layer | 🦀 Rust + `sysinfo`               |
| Bridge       | `flutter_rust_bridge`             |
| Backend      | Dart CLI (HttpServer + WebSocket) |
| Frontend     | Flutter Web / Browser             |

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/system-stats-dashboard.git
cd system-stats-dashboard
```

---

### 2. Install dependencies

#### Dart

```bash
dart pub get
```

#### Rust

```bash
rustc --version
```

If not installed: https://rustup.rs/

---

### 3. Build the Rust library

```bash
cd rust
cargo build
```

---

### 4. Generate FFI bindings

Run from project root:

```bash
flutter_rust_bridge_codegen generate \
--rust-root rust \
--rust-input crate::api \
--dart-output lib/rust/bridge_generated.dart
```

---

### 5. Run the CLI server

```bash
dart run bin/main.dart
```

---

### 6. Open the dashboard

```
http://localhost:8080
```

---

## 📡 WebSocket API

The server streams JSON data every second:

```json
{
  "totalMemory": 16384,
  "usedMemory": 8240,
  "freeMemory": 8144,
  "memoryUsagePercent": 50.3,
  "cpuUsage": 12.7,
  "timestamp": "2026-03-17T12:00:00Z"
}
```

---

## 📁 Project Structure

```
systemdashboardcli/
│
├── lib/
│   ├── rust/
│   │   ├── bridge_generated.dart
│   │   ├── frb_generated.dart
│   │   ├── frb_generated.io.dart
│   │   └── frb_generated.web.dart
│   │
│   ├── server.dart
│   ├── websocket.dart
│   └── src/
│
├── rust/
│   ├── src/
│   │   ├── api/
│   │   │   ├── mod.rs
│   │   │   └── simple.rs   
│   │   │
│   │   ├── lib.rs
│   │   └── frb_generated.rs
│   │
│   ├── Cargo.toml
│   └── target/
│
├── bin/
│   └── main.dart
│
├── web/
│
└── test/
```

---

## 🔍 Key Concepts

### 🦀 Rust as a Metrics Engine

Using the `sysinfo` crate, Rust collects:

* CPU usage
* Memory stats
* System-level metrics

---

### 🔗 FFI via flutter_rust_bridge

* Generates Rust + Dart bindings automatically
* Handles serialization/deserialization
* Provides async-safe APIs

---

### 🌐 WebSocket Streaming

* Dart collects stats from Rust
* Broadcasts to connected clients
* Enables real-time UI updates

---

## ⚡ Future Improvements

* 📊 Disk usage stats
* 🌍 Network I/O monitoring
* 🔄 Real-time streaming from Rust (no polling)
* 🧠 Process-level monitoring (like `htop`)
* 📱 Native Flutter dashboard

---

## 🤝 Contributing

Contributions are welcome!

* Open issues
* Suggest improvements
* Submit PRs

---

## 📄 License

MIT License

---

## 💡 Author

Built by **John Audu**



