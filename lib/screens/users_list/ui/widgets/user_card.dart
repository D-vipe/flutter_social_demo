import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/card_row.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String userName;
  const UserCard({
    Key? key,
    required this.name,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shadowColor: AppColors.mainTheme,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardRow(
                  value: userName,
                  title: AppDictionary.userName,
                  reduceWidth: 150,
                  valueStyle: AppTextStyle.comforta14W400),
              const SizedBox(
                height: 10,
              ),
              CardRow(
                  title: AppDictionary.name,
                  value: name,
                  reduceWidth: 94,
                  valueStyle: AppTextStyle.comforta14W400)
            ],
          ),
        ),
      ),
    );
  }
}
