// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/route_arguments/detail_page_arguments.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/redux/actions/album_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/screens/albums/bloc/albums_cubit.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_detail_view_model.dart';

class AlbumDetailScreen extends StatelessWidget {
  final DetailPageArgument arguments;
  const AlbumDetailScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumsCubit(),
      child: AlbumDetailView(
        id: arguments.id,
      ),
    );
  }
}

class AlbumDetailView extends StatefulWidget {
  final int id;
  const AlbumDetailView({Key? key, required this.id}) : super(key: key);

  @override
  State<AlbumDetailView> createState() => _AlbumDetailViewState();
}

class _AlbumDetailViewState extends State<AlbumDetailView> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AlbumDetailViewModel>(
      distinct: true,
      converter: (store) => store.state.albumDetailScreenState,
      onInit: (store) =>
          store.dispatch(GetAlbumDetailAction(albumId: widget.id)),
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            centerTitle: true,
            title: Text(
              state.album != null
                  ? state.album!.title
                  : AppDictionary.postDetailTitle,
            ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
          ),
          extendBody: true,
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return state.isLoading
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: state.isError == true
                                        ? ErrorPage(
                                            message: state.errorMessage!,
                                          )
                                        : const LoaderPage(),
                                  ),
                                ],
                              )
                            : state.album != null
                                ? Container(
                                    height: MediaQuery.of(context).size.height -
                                        150,
                                    alignment: Alignment.center,
                                    child: _DetailAlbumBody(
                                      photos: state.album!.photos ?? [],
                                    ),
                                  )
                                : const EmptyPage(
                                    message: GeneralErrors.emptyData);
                      },
                      childCount: 1,
                    )),
                    const SliverPadding(
                      sliver: null,
                      padding: EdgeInsets.only(bottom: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _DetailAlbumBody extends StatelessWidget {
  final List<Photo> photos;
  const _DetailAlbumBody({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: CarouselSlider(
        items: List.generate(
            photos.length,
            (i) => _PhotoCard(
                  url: photos[i].url,
                  title: photos[i].title,
                )),
        options: CarouselOptions(
          // aspectRatio: 2.0,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          autoPlay: false,
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final String url;
  final String title;
  const _PhotoCard({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              imageUrl: url.toString(),
              placeholder: (context, url) => Loader(
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      // width: double.maxFinite,
                      height: 30,
                      color: AppColors.black.withOpacity(.4),
                      child: Text(
                        title,
                        style: AppTextStyle.comforta10W400
                            .apply(color: AppColors.white),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
