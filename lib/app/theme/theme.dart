import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';

class AppTheme {
  static ThemeData baseTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Manrope')));
}
