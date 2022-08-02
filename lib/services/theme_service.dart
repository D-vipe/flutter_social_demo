// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Project imports:
import 'package:flutter_social_demo/services/shared_preferences.dart';

class ThemeService {
  static bool getCurrentTheme() {
    final Brightness deviceTheme =
        SchedulerBinding.instance.window.platformBrightness;
    final bool? lightTheme =
        SharedStorageService.getBool(PreferenceKey.lightTheme);

    return lightTheme ?? (deviceTheme == Brightness.light);
  }

  static bool isUserThemeSet() {
    return SharedStorageService.getBool(PreferenceKey.lightTheme) != null;
  }

  static Future<bool> setSavedTheme(bool val) async {
    return await SharedStorageService.setBool(PreferenceKey.lightTheme, !val);
  }

  static Future<bool> setPhoneBasedTheme() async {
    final Brightness deviceTheme =
        SchedulerBinding.instance.window.platformBrightness;
    await SharedStorageService.remove(PreferenceKey.lightTheme);

    // return bool value based on current device brightness
    return deviceTheme == Brightness.light;
  }
}
