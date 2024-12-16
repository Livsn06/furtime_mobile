import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furtime/screens/start/onwalk_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import 'screens/auth/signup_screen.dart';
import 'screens/start/splash_screen.dart';
import 'theme/_themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

