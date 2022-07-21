import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/screens/posts/bloc/posts_cubit.dart';
import 'package:flutter_social_demo/screens/posts/ui/widgets/post_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(),
      child: const PostsListView(),
    );
  }
}

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
  void initState() {
    super.initState();

    context.read<PostsCubit>().getList();
  }

  Future<void> _refreshScreen({
    required List<Post> list,
  }) async {
    await context.read<PostsCubit>().refreshList(oldList: list);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      final bool receivedState = state is PostReceived;
      final bool loadingState = state is PostRequested;
      final bool errorState = state is PostError;
      String errorMessage = '';
      List<Post>? posts;

      if (errorState) {
        errorMessage = state.error;
      }
      if (receivedState) {
        posts = state.list;
      }
      return loadingState
          ? const LoaderPage()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              header: const RefreshHeader(),
              onRefresh: () async {
                await _refreshScreen(list: posts ?? []);
              },
              child: receivedState
                  ? posts!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (c, i) => PostCard(
                            postId: posts![i].id,
                            title: posts[i].title,
                            body: posts[i].body,
                          ),
                          itemCount: posts.length,
                          padding: const EdgeInsets.only(bottom: 95),
                        )
                      : const EmptyPage(
                          message: GeneralErrors.emptyUsers,
                        )
                  : ErrorPage(
                      message: errorMessage,
                    ),
            );
    });
  }
}
