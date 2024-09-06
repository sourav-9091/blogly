import 'package:blog_firebase/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static _border([Color color = ColorManager.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        ColorManager.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(
        ColorManager.gradient2,
      ),
    ),
  );
}
