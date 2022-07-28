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
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.white,
          elevation: 3,
          shape: CircularNotchedRectangle(),
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
      );
}
