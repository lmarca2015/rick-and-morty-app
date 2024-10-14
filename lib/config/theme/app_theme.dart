import 'package:flutter/material.dart';

class AppTheme {

  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor
      )
    );
  }
}