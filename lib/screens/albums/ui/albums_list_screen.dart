// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_social_demo/redux/actions/album_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
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
  Widget build(BuildContext context) {
    super.build;

    return StoreConnector<AppState, AlbumListViewModel>(
      distinct: true,
      converter: (store) => store.state.albumsScreenState,
      onInit: (store) => store.dispatch(GetAlbumListAction()),
      builder: (_, state) {
        return state.isLoading
            ? const LoaderPage()
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                header: const RefreshHeader(),
                onRefresh: () {
                  StoreProvider.of<AppState>(context).dispatch(
                      RefreshAlbumListAction(oldList: state.albumList ?? []));
                },
                child: (state.isError == true)
                    ? ErrorPage(
                        message: state.errorMessage!,
                      )
                    : (state.albumList != null && state.albumList!.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15),
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              children: List.generate(
                                  state.albumList!.length,
                                  (i) => AlbumCard(
                                        id: state.albumList![i].id,
                                        title: state.albumList![i].title,
                                        thumbnailUrl:
                                            (state.albumList![i].photos !=
                                                        null &&
                                                    state.albumList![i].photos!
                                                        .isNotEmpty)
                                                ? state.albumList![i].photos![0]
                                                    .thumbnailUrl
                                                : null,
                                      )),
                            ),
                          )
                        : const EmptyPage(
                            message: GeneralErrors.emptyUsers,
                          ));
      },
    );
  }
}
