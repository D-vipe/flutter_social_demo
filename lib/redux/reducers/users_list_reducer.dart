import 'package:flutter_social_demo/models/user_model.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:flutter_social_demo/redux/viewmodels/users_list_view_model.dart';
import 'package:redux/redux.dart';

final usersListReducer = combineReducers<UsersListViewModel>([
  TypedReducer<UsersListViewModel, GetUsersListSucceedAction>(_fetch),
  TypedReducer<UsersListViewModel, RefreshUsersListAction>(_refresh),
  TypedReducer<UsersListViewModel, LoadMoreUsersAction>(_loadMore),
  TypedReducer<UsersListViewModel, GetMoreUsersSucceedAction>(_loadMoreSuccess),
]);

UsersListViewModel _fetch(UsersListViewModel state, GetUsersListSucceedAction action) {
  List<User> updatedList = List<User>.from(action.usersList);

  return state.copyWith(isLoading: false, isRefreshing: false, isLoadingMore: false, usersList: updatedList);
}

UsersListViewModel _refresh(UsersListViewModel state, RefreshUsersListAction action) {
  return state.copyWith(isLoading: false, isRefreshing: true, isLoadingMore: false);
}

UsersListViewModel _loadMore(UsersListViewModel state, LoadMoreUsersAction action) {
  return state.copyWith(isLoading: false, isRefreshing: false, isLoadingMore: true);
}

UsersListViewModel _loadMoreSuccess(UsersListViewModel state, GetMoreUsersSucceedAction action) {
  List<User> newList = state.usersList ?? [];
  newList.addAll(action.usersList);

  return state.copyWith(isLoading: false, isRefreshing: false, isLoadingMore: false, usersList: newList);
}
