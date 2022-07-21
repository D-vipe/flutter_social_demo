import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

class EmptyPage extends StatelessWidget {
  final String message;
  const EmptyPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: AppTextStyle.comforta16W400,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        )
      ],
    );
  }
}