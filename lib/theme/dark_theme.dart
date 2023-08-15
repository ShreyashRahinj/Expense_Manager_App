import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey[850]!,
        secondary: Colors.blue),
    hintColor: Colors.grey[400],
    highlightColor: Colors.grey[800]);
