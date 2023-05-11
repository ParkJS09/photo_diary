import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF616161)),
  ),
);
