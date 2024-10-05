import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import 'screens/intro/splash.dart';
import 'utils/_init.dart';
import 'utils/_routes.dart';

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
      title: dotenv.env['APP_NAME'] ?? '',
      initialBinding: RootBinding(),
      initialRoute: Routes.getSplashScreen,
      getPages: Routes.screens,
      home: SplashScreen(),
    );
  }
}
