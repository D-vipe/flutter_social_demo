import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text(
            AppDictionary.refreshTip,
            style: AppTextStyle.comforta12W400,
          );
        } else if (mode == LoadStatus.loading) {
          body = const Loader(
            color: AppColors.mainTheme,
          );
        } else if (mode == LoadStatus.failed) {
          body = const Text(GeneralErrors.loadError,
              style: AppTextStyle.comforta12W400);
        } else if (mode == LoadStatus.canLoading) {
          body = const Text(AppDictionary.releaseTip,
              style: AppTextStyle.comforta12W400);
        } else {
          body = const Text(AppDictionary.noMoreData,
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
