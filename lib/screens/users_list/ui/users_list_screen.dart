// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/redux/viewmodels/users_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_footer.dart';
import 'package:flutter_social_demo/app/uikit/smart_refresh_components/refresh_header.dart';
import 'package:flutter_social_demo/models/user_model.dart';
import 'package:flutter_social_demo/screens/users_list/ui/widgets/user_card.dart';
import 'package:redux/redux.dart';

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

    // context.read<UsersListCubit>().getList();
  }

  Future<void> _refreshScreen() async {
    // await context.read<UsersListCubit>().refreshList(oldList: list);
    _refreshController.refreshCompleted();
  }

  Future<void> _loadMore({required List<User> list}) async {
    // await context.read<UsersListCubit>().loadMore(oldList: list);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, UsersListViewModel>(
      distinct: true,
      converter: (store) => store.state.usersListState,
      onInit: (store) => store.dispatch(GetUsersListAction()),
      onDidChange: (oldState, newState) {
        if (!newState.isRefreshing && _refreshController.isRefresh) {
          _refreshController.refreshCompleted();
        }
        if (!newState.isLoadingMore && _refreshController.isLoading) {
          _refreshController.loadComplete();
        }
      },
      builder: (_, state) {
        return state.isLoading
            ? const LoaderPage()
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: !state.isLoadingMore ? true : false,
                controller: _refreshController,
                header: const RefreshHeader(),
                footer: const LoadMoreFooter(),
                onRefresh: () async {
                  StoreProvider.of<AppState>(context).dispatch(
                      RefreshUsersListAction(oldList: state.usersList ?? []));
                },
                onLoading: () async {
                  StoreProvider.of<AppState>(context).dispatch(
                      LoadMoreUsersAction(oldList: state.usersList ?? []));
                  // await _loadMore(list: state.usersList ?? []);
                },
                child: state.usersList!.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (c, i) => UserCard(
                          name: state.usersList![i].name,
                          userName: state.usersList![i].username,
                        ),
                        itemExtent: 94.0,
                        itemCount: state.usersList!.length,
                        padding: const EdgeInsets.only(bottom: 95),
                      )
                    : const EmptyPage(
                        message: GeneralErrors.emptyUsers,
                      ));
      },
    );
  }
}
