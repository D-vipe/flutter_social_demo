// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/route_arguments/detail_page_arguments.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/routes_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';

class AlbumCard extends StatelessWidget {
  final int id;
  final String title;
  final String? thumbnailUrl;
  final double? margin;
  const AlbumCard({
    Key? key,
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routes.detailAlbum,
          arguments: DetailPageArgument(
            id: id,
          )),
      child: Container(
        margin:
            margin != null ? EdgeInsets.symmetric(horizontal: margin!) : null,
        child: Stack(
          children: [
            thumbnailUrl != null
                ? CachedNetworkImage(
                    width: (MediaQuery.of(context).size.width / 3) - 6,
                    fit: BoxFit.cover,
                    imageUrl: thumbnailUrl.toString(),
                    placeholder: (context, url) => const Loader(
                      color: AppColors.mainTheme,
                      size: 20,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Container(),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: (MediaQuery.of(context).size.width / 3) - 6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  height: 30,
                  color: AppColors.black.withOpacity(.4),
                  child: Text(
                    title,
                    style: AppTextStyle.comforta10W400
                        .apply(color: AppColors.white),
                    overflow: TextOverflow.fade,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
