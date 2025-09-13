import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'app/data/enums.dart';
import 'app/data/models/menu_info.dart';
import 'app/modules/views/homepage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Android Initialization
  var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  
  // iOS/macOS Initialization (DarwinInitializationSettings)
  var darwinInitializationSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  
  // Windows Initialization
  var initializationSettingsWindows = WindowsInitializationSettings(
    appName: 'Flutter Alarm Clock',
    appUserModelId: 'flutter_alarm_clock',
    guid: '410e9b30-cc4c-47b2-a238-c29a6fb5cb84',
    iconPath: 'flutter_alarm_clock_master\\flutter_clock_app.png', // Optional: path to your app icon
  );

  // Combine Initialization Settings
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: darwinInitializationSettings,
    macOS: darwinInitializationSettings,
    windows: initializationSettingsWindows,
  );

  // Initialize the plugin
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      debugPrint('notification payload: ${response.payload}');
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: HomePage(),
      ),
    ),
  );
}

// Background Notification Handler
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('Background notification payload: ${notificationResponse.payload}');
}