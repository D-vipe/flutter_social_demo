import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/config/route_arguments/post_detail_arguments.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/routes_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final String title;
  final String body;
  const PostCard({
    Key? key,
    required this.title,
    required this.body,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routes.detailPost,
          arguments: PostDetailArguments(
            id: postId,
          )),
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.comforta16W600
                      .apply(color: AppColors.orange),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body,
                  style: AppTextStyle.comforta14W400,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}