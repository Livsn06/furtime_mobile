import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Rx<Size> SCREEN_SIZE = Rx<Size>(const Size(0, 0));
Rx<ThemeData> APP_THEME = Rx<ThemeData>(ThemeData.light());
Rx<String> APP_TITLE = Rx<String>(dotenv.env['APP_TITLE'] ?? 'Unknown');
Rx<String> API_BASE_URL = Rx<String>(dotenv.env['API_BASE_URL'] ?? 'Unknown');
