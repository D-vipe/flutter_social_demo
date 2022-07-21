import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

class CardRow extends StatelessWidget {
  final String title;
  final String value;
  final num? reduceWidth;
  final TextStyle? valueStyle;
  const CardRow({
    Key? key,
    required this.title,
    required this.value,
    this.reduceWidth,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: AppTextStyle.comforta14W400.apply(color: AppColors.orange),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: reduceWidth != null
              ? (MediaQuery.of(context).size.width - reduceWidth!)
              : MediaQuery.of(context).size.width,
          child: Text(
            value,
            style: valueStyle ?? AppTextStyle.comforta16W600,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
