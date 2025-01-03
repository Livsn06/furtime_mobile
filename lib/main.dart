import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import 'helpers/db_sqflite.dart';
import 'screens/start/splash_screen.dart';
import 'theme/_themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(
        channelKey: 'basic_channel', 
        channelName: 'Basic Notifications', 
        channelDescription: 'notification for channel basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        locked: true
      ),
    ],
    debug: true,
  );
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE.value,
      theme: customThemeData(),
      home: const SplashScreen(),
    );
  }
}
