// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/screens/albums/bloc/albums_cubit.dart';
import 'package:flutter_social_demo/screens/albums/ui/widgets/album_card.dart';

class AlbumsListView extends StatefulWidget {
  const AlbumsListView({Key? key}) : super(key: key);

  @override
  State<AlbumsListView> createState() => _AlbumsListViewState();
}

class _AlbumsListViewState extends State<AlbumsListView>
    with AutomaticKeepAliveClientMixin<AlbumsListView> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    context.read<AlbumsCubit>().getList();
  }

  Future<void> _refreshScreen({
    required List<Album> list,
  }) async {
    await context.read<AlbumsCubit>().refreshList(oldList: list);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build;
    return BlocBuilder<AlbumsCubit, AlbumsState>(
      builder: (context, state) {
        final bool receivedState = state is AlbumsReceived;
        final bool loadingState = state is AlbumsRequested;
        final bool errorState = state is AlbumError;
        String errorMessage = '';
        List<Album>? albums;

        if (errorState) {
          errorMessage = state.error;
        }
        if (receivedState) {
          albums = state.list;
        }

        return loadingState
            ? const LoaderPage()
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                header: const RefreshHeader(),
                onRefresh: () async {
                  await _refreshScreen(list: albums ?? []);
                },
                child: receivedState
                    ? albums!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15),
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              children: List.generate(
                                  albums.length,
                                  (i) => AlbumCard(
                                        id: albums![i].id,
                                        title: albums[i].title,
                                        thumbnailUrl: (albums[i].photos !=
                                                    null &&
                                                albums[i].photos!.isNotEmpty)
                                            ? albums[i].photos![0].thumbnailUrl
                                            : null,
                                      )),
                            ),
                          )
                        : const EmptyPage(
                            message: GeneralErrors.emptyUsers,
                          )
                    : ErrorPage(
                        message: errorMessage,
                      ),
              );
      },
    );
  }
}
