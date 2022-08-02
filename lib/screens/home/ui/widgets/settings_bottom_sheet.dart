import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/main.dart';
import 'package:flutter_social_demo/services/theme_service.dart';

class ProfileSettingsForm extends StatefulWidget {
  // final Function themeSwitch;
  final double height;
  const ProfileSettingsForm({
    Key? key,
    required this.height,
    // required this.themeSwitch,
  }) : super(key: key);

  @override
  State<ProfileSettingsForm> createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  bool appThemeEnabled = true;
  bool lightTheme = false;

  @override
  void initState() {
    super.initState();

    appThemeEnabled = !ThemeService.isUserThemeSet();
    lightTheme = ThemeService.getCurrentTheme();
  }

  void _togglePhoneTheme(bool value) {
    ThemeService.setPhoneBasedTheme().then((value) {
      setState(() {
        appThemeEnabled = true;
        lightTheme = value;
      });
      MyApp.of(context)!.changeTheme(value);
    });
  }

  Future<void> _toggleUserTheme(bool value) async {
    ThemeService.setSavedTheme(value).then((res) {
      setState(() {
        appThemeEnabled = false;
        lightTheme = !value;
      });
      MyApp.of(context)!.changeTheme(!value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: Text(
                          '${AppDictionary.usePhoneTheme}:',
                          style: AppTextStyle.comforta14W400.apply(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Switch(
                          inactiveThumbColor: lightTheme
                              ? AppColors.blue.withOpacity(.5)
                              : AppColors.lightDark,
                          inactiveTrackColor: lightTheme
                              ? AppColors.black.withOpacity(.3)
                              : AppColors.white,
                          activeTrackColor: lightTheme
                              ? AppColors.black.withOpacity(.3)
                              : AppColors.pink.withOpacity(.5),
                          activeColor:
                              lightTheme ? AppColors.blue : AppColors.amber,
                          value: appThemeEnabled,
                          onChanged: _togglePhoneTheme)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: Text(
                          '${AppDictionary.setDarkTheme}:',
                          style: AppTextStyle.comforta14W400.apply(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Switch(
                          inactiveThumbColor: lightTheme
                              ? AppColors.blue.withOpacity(.5)
                              : AppColors.lightDark,
                          inactiveTrackColor: lightTheme
                              ? AppColors.black.withOpacity(.3)
                              : AppColors.white,
                          activeTrackColor: lightTheme
                              ? AppColors.black.withOpacity(.3)
                              : AppColors.pink.withOpacity(.5),
                          activeColor:
                              lightTheme ? AppColors.blue : AppColors.amber,
                          value: !lightTheme && !appThemeEnabled,
                          onChanged: (value) async {
                            await _toggleUserTheme(value);
                          })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
