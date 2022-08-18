// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_social_demo/redux/actions/posts_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/redux/viewmodels/posts_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/screens/posts/ui/widgets/post_card.dart';

class PostsListView extends StatefulWidget {
  const PostsListView({Key? key}) : super(key: key);

  @override
  State<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView>
    with AutomaticKeepAliveClientMixin<PostsListView> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StoreConnector<AppState, PostsViewModel>(
      distinct: true,
      converter: (store) => store.state.postsScreenState,
      onInit: (store) => store.dispatch(GetPostListAction()),
      onDidChange: (oldState, newState) {
        if (newState.isRefreshing == false && _refreshController.isRefresh) {
          _refreshController.refreshCompleted();
        }
      },
      builder: (_, state) {
        return state.isLoading
            ? const LoaderPage()
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                header: const RefreshHeader(),
                onRefresh: () async {
                  StoreProvider.of<AppState>(context).dispatch(
                      RefreshPostListAction(oldList: state.postList ?? []));
                },
                child: (state.isError == true)
                    ? ErrorPage(
                        message: state.errorMessage!,
                      )
                    : (state.postList != null && state.postList!.isNotEmpty)
                        ? ListView.builder(
                            itemBuilder: (c, i) => PostCard(
                              postId: state.postList![i].id,
                              title: state.postList![i].title,
                              body: state.postList![i].body,
                            ),
                            itemCount: state.postList!.length,
                            padding: const EdgeInsets.only(bottom: 115),
                          )
                        : const EmptyPage(
                            message: GeneralErrors.emptyUsers,
                          ));
      },
    );
  }
}
