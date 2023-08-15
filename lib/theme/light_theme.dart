import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey[100]!,
    primary: Colors.grey[400]!,
    secondary: Colors.red,
  ),
  hintColor: Colors.grey[400],
  highlightColor: Colors.grey[200],
);
