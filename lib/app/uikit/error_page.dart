import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

class ErrorPage extends StatelessWidget {
  final Widget? appBar;
  final String message;
  const ErrorPage({Key? key, required this.message, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar ?? Container(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: AppColors.errorRed,
                size: 45,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  message,
                  style: AppTextStyle.comforta16W400
                      .apply(color: AppColors.errorRed),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        )
      ],
    );
  }
}
