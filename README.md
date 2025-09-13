# ⏰ Flutter Alarm Clock

A cross-platform Flutter alarm clock app with local notifications, SQLite persistence, and provider-based state management.  
Supports **Android, iOS/macOS, and Windows** with platform-specific initialization and assets.

---

## ✨ Features
- Schedule and manage alarms with titles, times, and gradient color tags (stored in SQLite with `sqflite`).
- Local notifications with foreground/background tap handling (`flutter_local_notifications`).
- Provider state management for navigation and UI state.
- Multi-platform initialization with platform-specific assets and permissions.

---

## 🏗 Architecture
- **Data Layer**: `AlarmHelper` – singleton wrapper over `sqflite` with CRUD operations.
- **Model**: `AlarmInfo` – maps to/from DB rows for persistence and UI.
- **Presentation**: `HomePage` as entry screen, with `MenuInfo` (Provider) controlling current `MenuType`.
- **Notifications**: `FlutterLocalNotificationsPlugin` initialized for Android, Darwin (iOS/macOS), and Windows.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured
- Platform toolchains set up:
  - Android Studio (for Android)
  - Xcode (for iOS/macOS)
  - Visual Studio (for Windows Desktop)

### Installation
```bash
flutter pub get
Platform Setup
Android

Add a proper notification icon (codex_logo) under android/app/src/main/res/drawable.
Configure notification permissions in AndroidManifest.xml for API 33+ (POST_NOTIFICATIONS).

iOS / macOS
DarwinInitializationSettings requests alert, badge, and sound permissions.
Ensure Info.plist contains required keys.
Enable push/local notifications capability.

Windows
Configure WindowsInitializationSettings with appName, appUserModelId, and iconPath.
Ensure toast notifications are enabled in Windows system settings.

Running the App
flutter run



