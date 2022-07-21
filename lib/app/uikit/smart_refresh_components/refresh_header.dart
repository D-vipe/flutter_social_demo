import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends StatelessWidget {
  const RefreshHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body = const Loader(
          color: AppColors.mainTheme,
        );
        if (mode == RefreshStatus.idle) {
          body = const Text(
            AppDictionary.loadMoreTip,
            style: AppTextStyle.comforta12W400,
          );
        } else if (mode == RefreshStatus.refreshing) {
          body = const Loader(
            color: AppColors.mainTheme,
          );
        } else if (mode == RefreshStatus.failed) {
          body = const Text(GeneralErrors.loadError,
              style: AppTextStyle.comforta12W400);
        } else if (mode == RefreshStatus.canRefresh) {
          body = const Text(AppDictionary.releaseTip,
              style: AppTextStyle.comforta12W400);
        }
        return SizedBox(
          height: 45.0,
          child: Center(child: body),
        );
      },
    );
  }
}
