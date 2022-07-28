// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.blue,
          onPrimary: AppColors.blue,
          secondary: AppColors.pink,
          onSecondary: AppColors.pink,
          error: AppColors.errorRed,
          onError: AppColors.errorRed,
          background: AppColors.white,
          onBackground: AppColors.white,
          surface: AppColors.white,
          onSurface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Manrope'),
        ),
      );

  static ThemeData darkTheme() => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.amber,
          onPrimary: AppColors.amber,
          secondary: AppColors.red,
          onSecondary: AppColors.red,
          error: AppColors.errorRed,
          onError: AppColors.errorRed,
          background: AppColors.white,
          onBackground: AppColors.white,
          surface: AppColors.white,
          onSurface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.amber,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Manrope'),
        ),
      );
}
