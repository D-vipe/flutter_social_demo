import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_footer.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/screens/users_list/bloc/users_list_cubit.dart';
import 'package:flutter_social_demo/screens/users_list/ui/widgets/user_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersListCubit(),
      child: const UsersListView(),
    );
  }
}

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView>
    with AutomaticKeepAliveClientMixin<UsersListView> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    context.read<UsersListCubit>().getList();
  }

  Future<void> _refreshScreen({
    required List<User> list,
  }) async {
    await context.read<UsersListCubit>().refreshList(oldList: list);
    _refreshController.refreshCompleted();
  }

  Future<void> _loadMore({required List<User> list}) async {
    await context.read<UsersListCubit>().loadMore(oldList: list);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UsersListCubit, UsersListState>(
        builder: (context, state) {
      final bool receivedState = state is UsersListReceived;
      final bool receivedMoreState = state is UsersListReceivedMore;
      final bool loadingState = state is UsersListRequested;
      final bool errorState = state is UsersListError;
      List<User>? users;

      String errorMessage = '';

      if (errorState) {
        errorMessage = state.error;
      }

      if (receivedState) {
        users = state.list;
      }
      if (receivedMoreState) {
        users = state.list;
      }

      return loadingState
          ? const LoaderPage()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: (receivedState || receivedMoreState) ? true : false,
              controller: _refreshController,
              header: const RefreshHeader(),
              footer: const LoadMoreFooter(),
              onRefresh: () async {
                await _refreshScreen(list: users ?? []);
              },
              onLoading: () async {
                await _loadMore(list: users ?? []);
              },
              child: receivedState || receivedMoreState
                  ? users!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (c, i) => UserCard(
                            name: users![i].name,
                            userName: users[i].username,
                          ),
                          itemExtent: 94.0,
                          itemCount: users.length,
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
