Flutter Alarm Clock
A cross-platform Flutter alarm clock app with local notifications, SQLite persistence, and a provider-based UI state. Supports Android, iOS/macOS (Darwin), and Windows with platform-specific initialization and assets.

Features
Schedule and manage alarms with titles, times, and gradient color tags stored in SQLite via sqflite.

Local notifications with foreground and background tap handling using flutter_local_notifications.

Provider state management for menu/navigation state in the home view.

Multi-platform initialization (Android, iOS/macOS, Windows) with platform-specific assets and permissions.

Architecture
Data layer: AlarmHelper provides a singleton wrapper over sqflite with CRUD for the alarm table (id, title, alarmDateTime, isPending, gradientColorIndex).

Model: AlarmInfo (referenced) maps to/from DB rows for persistence and retrieval in the UI flow.

Presentation: HomePage is the entry screen, with MenuInfo (Provider) controlling the current MenuType (e.g., clock/alarms).

Notifications: FlutterLocalNotificationsPlugin initialized with Android, Darwin (iOS/macOS), and Windows settings, including background tap handler with @pragma('vm:entry-point).

Screenshots
Add screenshots or GIFs of the clock view, alarm list, and create-alarm flow.

Place images under assets/images and reference them here.

Getting Started
Prerequisites:

Flutter SDK installed and configured.

Platform toolchains set up (Android Studio/Xcode/Visual Studio Desktop as applicable).

Install dependencies:

flutter pub get.

Ensure assets (icons) exist per platform configuration before building.

Run:

flutter run for a connected device/emulator.

flutter devices to list targets.

Platform Setup
Android:

AndroidInitializationSettings uses 'codex_logo' as the notification icon; add this resource to android/app/src/main/res/drawable as a proper notification icon (monochrome).

Configure AndroidManifest permissions for notifications on Android 13+ if targeting API 33+ (POST_NOTIFICATIONS).

iOS/macOS:

DarwinInitializationSettings requests alert, badge, and sound permissions at runtime; ensure Info.plist contains NSCalendarsUsageDescription if needed for calendar-like features in future, and enable push/local notifications capability.

Test background response via onDidReceiveBackgroundNotificationResponse with proper app lifecycle handling.

Windows:

WindowsInitializationSettings sets appName, appUserModelId, guid, and iconPath; ensure the icon path exists (flutter_alarm_clock_master/flutter_clock_app.png) and package assets accordingly.

Validate toast notifications are enabled in Windows settings for the app.

Database
Schema:

Table: alarm.

Columns:

id INTEGER PRIMARY KEY AUTOINCREMENT.

title TEXT NOT NULL.

alarmDateTime TEXT NOT NULL (store ISO 8601 string).

isPending INTEGER (0/1).

gradientColorIndex INTEGER.

Helper:

AlarmHelper initializes the database at getDatabasesPath()/alarm.db and exposes insertAlarm, getAlarms, and delete(id) for CRUD.

AlarmInfo.fromMap/toMap bridges DB rows and app models; ensure model aligns with schema and date parsing.

Notifications
Initialization:

FlutterLocalNotificationsPlugin is initialized in main with handlers for foreground and background taps.

Background handler function notificationTapBackground is a VM entry point to ensure it’s invokable when the app is terminated.

Usage:

Schedule platform-specific notifications when creating alarms in UI (implement scheduling code where alarms are created).

Handle payloads in onDidReceiveNotificationResponse and notificationTapBackground to navigate to alarm details.

State Management
Provider is used for MenuInfo(MenuType.clock) to drive UI state on HomePage.

Extend MenuType and MenuInfo to support additional tabs like Timer, Stopwatch, and Settings as needed.

Project Structure
lib/main.dart: App bootstrap and notification setup.

lib/app/modules/views/homepage.dart: Entry UI (implement views for clock and alarms).

lib/app/data/models: AlarmInfo, MenuInfo, enums.dart for MenuType.

lib/app/data/db: alarm_helper.dart for SQLite access.

Development Notes
Ensure all async database and notification calls are awaited in UI flows to avoid race conditions.

Validate icon assets across platforms; Android uses a notification icon resource name, Windows uses an explicit file path.

Prefer storing alarmDateTime in UTC or ISO 8601 and converting to local time for display to avoid DST issues.

Roadmap
Add scheduling logic to create notifications at alarmDateTime with repeat options.

Snooze/dismiss actions via notification action buttons.

Alarm tones, vibration patterns, and custom sounds per alarm.

Migrate to Drift/Isar if reactive queries or advanced schema migrations are needed.

Running Tests
Add unit tests for AlarmHelper CRUD and AlarmInfo serialization.

Widget tests for list rendering and notification tap navigation.

Troubleshooting
If notifications don’t appear on Android 13+, request POST_NOTIFICATIONS permission and verify channel configuration.

If Windows icon or toasts fail, check iconPath and appUserModelId consistency in WindowsInitializationSettings.

If database isn’t created, log the resolved path from getDatabasesPath and ensure onCreate executes once at version 1.

Contributing
Fork, create a feature branch, and open a PR with a clear description.

Follow Dart/Flutter lints and format with dart format before submitting.

Acknowledgements
Built with Flutter and flutter_local_notifications; persistence via sqflite; state via provider.

is this name ok or is there any name convention is there such that people who selects us f.
