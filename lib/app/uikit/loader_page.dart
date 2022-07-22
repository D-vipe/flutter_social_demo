// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';

class LoaderPage extends StatelessWidget {
  final Widget? appBar;
  const LoaderPage({Key? key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar ?? Container(),
        Expanded(
          child: Container(
            color: AppColors.black.withOpacity(.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Loader(
                  size: 40,
                  color: AppColors.mainTheme,
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
