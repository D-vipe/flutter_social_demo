// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

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
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.white,
          elevation: 3,
          shape: CircularNotchedRectangle(),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 3,
          unselectedIconTheme: IconThemeData(
            color: AppColors.dark,
            size: 25,
          ),
          selectedIconTheme: IconThemeData(
            color: AppColors.blue,
            size: 35,
          ),
          showUnselectedLabels: false,
          unselectedLabelStyle: TextStyle(color: AppColors.dark),
          selectedLabelStyle: TextStyle(color: AppColors.blue),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.blue,
            textStyle: AppTextStyle.comforta16W400.apply(color: AppColors.white),
          ),
        ),
      );

  static ThemeData darkTheme() => ThemeData(
      canvasColor: AppColors.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.amber,
        onPrimary: AppColors.amber,
        secondary: AppColors.orange,
        onSecondary: AppColors.orange,
        error: AppColors.errorRed,
        onError: AppColors.errorRed,
        background: AppColors.lightDark,
        onBackground: AppColors.dark,
        surface: AppColors.white,
        onSurface: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black.withOpacity(.1),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Manrope'),
        iconTheme: const IconThemeData(color: AppColors.pink),
        actionsIconTheme: const IconThemeData(color: AppColors.pink),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        // color: AppColors.amber,
        elevation: 3,
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.dark,
        elevation: 3,
        unselectedIconTheme: IconThemeData(
          color: AppColors.white,
          size: 25,
        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.orange,
          size: 35,
        ),
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(color: AppColors.white),
        selectedLabelStyle: TextStyle(color: AppColors.orange),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.pink,
          textStyle: AppTextStyle.comforta16W400.apply(color: AppColors.white),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.pink, elevation: 3));
}
