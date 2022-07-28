// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/card_row.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/repository/models/album_model.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/repository/models/profile_model.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/screens/albums/ui/widgets/album_card.dart';
import 'package:flutter_social_demo/screens/posts/ui/widgets/post_card.dart';
import 'package:flutter_social_demo/screens/profile/bloc/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final Function onChangedTab;
  const ProfileScreen({Key? key, required this.onChangedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: ProfileView(
        onChangedTab: onChangedTab,
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  final Function onChangedTab;
  const ProfileView({
    Key? key,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with AutomaticKeepAliveClientMixin<ProfileView> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    context.read<ProfileCubit>().getProfile();
  }

  Future<void> _refreshScreen({
    required Profile? data,
  }) async {
    await context.read<ProfileCubit>().refreshProfile(oldData: data);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      final bool receivedState = state is ProfileReceived;
      final bool loadingState = state is ProfileRequested;
      final bool errorState = state is ProfileError;
      String errorMessage = '';
      Profile? profile;

      if (errorState) {
        errorMessage = state.error;
      }
      if (receivedState) {
        profile = state.data;
      }

      return loadingState
          ? const LoaderPage(
              appBar: _ProfileAppBar(
                title: AppBarTitles.userProfile,
              ),
            )
          : Column(
              children: [
                _ProfileAppBar(
                  title: (receivedState && profile != null) ? profile.user.username : AppBarTitles.userProfile,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: _refreshController,
                    header: const RefreshHeader(),
                    onRefresh: () async {
                      await _refreshScreen(data: profile);
                    },
                    child: receivedState
                        ? profile != null
                            ? ListView(
                                children: [
                                  _ProfileCard(
                                    user: profile.user,
                                  ),
                                  _ProfilePosts(
                                    onChangedTab: widget.onChangedTab,
                                    posts: profile.posts ?? [],
                                  ),
                                  _ProfileAlbums(onChangedTab: widget.onChangedTab, albums: profile.albums ?? [])
                                ],
                              )
                            : const EmptyPage(
                                message: GeneralErrors.emptyUsers,
                                appBar: _ProfileAppBar(
                                  title: AppBarTitles.userProfile,
                                ),
                              )
                        : ErrorPage(
                            message: errorMessage,
                            appBar: const _ProfileAppBar(
                              title: AppBarTitles.userProfile,
                            )),
                  ),
                ),
              ],
            );
    });
  }
}

class _ProfileCard extends StatelessWidget {
  final User user;
  const _ProfileCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fullAddress = '${user.address.zipcode}, ${user.address.city}, ${user.address.street}, ${user.address.suite}';

    return Container(
      margin: const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 15),
      child: Card(
        elevation: 15,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: 'https://ru.seaicons.com/wp-content/uploads/2016/06/The-Witcher-1-icon.png',
                    placeholder: (context, url) => Loader(
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardRow(
                      value: user.name,
                      title: AppDictionary.name,
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 109,
                      valueOverflow: false,
                    ),
                    const SizedBox(height: 5),
                    CardRow(
                      value: user.email,
                      title: AppDictionary.email,
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 109,
                      valueOverflow: false,
                    ),
                    const SizedBox(height: 5),
                    CardRow(
                      value: user.phone,
                      title: AppDictionary.phone,
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 125,
                      valueOverflow: false,
                    ),
                    const SizedBox(height: 5),
                    CardRow(
                      value: user.website,
                      title: AppDictionary.website,
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 109,
                      valueOverflow: false,
                    ),
                    const SizedBox(height: 5),
                    const CardRow(
                      title: AppDictionary.company,
                      value: '',
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 139,
                      valueOverflow: false,
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardRow(
                            value: user.company.name,
                            title: AppDictionary.name,
                            valueStyle: AppTextStyle.comforta14W400,
                            reduceWidth: 119,
                            valueOverflow: false,
                          ),
                          const SizedBox(height: 5),
                          CardRow(
                            value: user.company.bs,
                            title: AppDictionary.bsTitle,
                            valueStyle: AppTextStyle.comforta14W400,
                            reduceWidth: 130,
                            valueOverflow: false,
                          ),
                          const SizedBox(height: 5),
                          CardRow(
                            value: '`${user.company.catchPhrase}`',
                            title: AppDictionary.catchPhrase,
                            valueStyle: AppTextStyle.comforta14W400.apply(fontStyle: FontStyle.italic),
                            reduceWidth: 130,
                            valueOverflow: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    CardRow(
                      title: AppDictionary.address,
                      value: fullAddress,
                      valueStyle: AppTextStyle.comforta14W400,
                      reduceWidth: 109,
                      valueOverflow: false,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePosts extends StatelessWidget {
  final Function onChangedTab;
  final List<Post> posts;
  const _ProfilePosts({Key? key, required this.posts, required this.onChangedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChangedTab.call(1);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          const Text(
            AppDictionary.recentPost,
            style: AppTextStyle.comforta14W400,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 125,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int i) {
                return PostCard(
                  width: MediaQuery.of(context).size.width / 2,
                  title: posts[i].title,
                  postId: posts[i].id,
                  body: posts[i].body,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class _ProfileAlbums extends StatelessWidget {
  final Function onChangedTab;
  final List<Album> albums;
  const _ProfileAlbums({Key? key, required this.albums, required this.onChangedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChangedTab.call(2);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          const Text(
            AppDictionary.recentAlbums,
            style: AppTextStyle.comforta14W400,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 125,
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              itemBuilder: (BuildContext context, int i) {
                return AlbumCard(
                  margin: 10,
                  id: albums[i].id,
                  title: albums[i].title,
                  thumbnailUrl: (albums[i].photos != null && albums[i].photos!.isNotEmpty) ? albums[i].photos![0].thumbnailUrl : null,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  final String title;
  const _ProfileAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 97,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: AppColors.black.withOpacity(.3),
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: AppTextStyle.comforta16W400.apply(color: AppColors.white),
      ),
    );
  }
}
