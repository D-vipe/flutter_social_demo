// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';

class RefreshHeader extends StatelessWidget {
  const RefreshHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body = Loader(
          color: Theme.of(context).colorScheme.primary,
        );
        if (mode == RefreshStatus.idle) {
          body = const Text(
            AppDictionary.loadMoreTip,
            style: AppTextStyle.comforta12W400,
          );
        } else if (mode == RefreshStatus.refreshing) {
          body = Loader(
            color: Theme.of(context).colorScheme.primary,
          );
        } else if (mode == RefreshStatus.failed) {
          body = const Text(GeneralErrors.loadError, style: AppTextStyle.comforta12W400);
        } else if (mode == RefreshStatus.canRefresh) {
          body = const Text(AppDictionary.releaseTip, style: AppTextStyle.comforta12W400);
        }
        return SizedBox(
          height: 45.0,
          child: Center(child: body),
        );
      },
    );
  }
}
