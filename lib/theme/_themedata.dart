import 'package:flutter/material.dart';

ThemeData customThemeData() {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      secondary: Colors.deepOrange,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.grey,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      primaryFixedDim: Color(0xFF7D7D7D),
      onError: Colors.white,
    ),
  );
}
