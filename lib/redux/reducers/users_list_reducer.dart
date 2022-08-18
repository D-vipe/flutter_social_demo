import 'package:flutter_social_demo/api/models/user_model.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:flutter_social_demo/screens/users_list/view_model/users_list_view_model.dart';
import 'package:redux/redux.dart';

final usersListReducer = combineReducers<UsersListViewModel>([
  TypedReducer<UsersListViewModel, GetUsersListSucceedAction>(_fetch),
  TypedReducer<UsersListViewModel, RefreshUsersListAction>(_refresh),
  TypedReducer<UsersListViewModel, LoadMoreUsersAction>(_loadMore),
  TypedReducer<UsersListViewModel, GetMoreUsersSucceedAction>(_loadMoreSuccess),
  TypedReducer<UsersListViewModel, GetUsersListErrorAction>(_errorHandler),
]);

UsersListViewModel _fetch(
    UsersListViewModel state, GetUsersListSucceedAction action) {
  List<User> updatedList = List<User>.from(action.usersList);

  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isLoadingMore: false,
      usersList: updatedList);
}

UsersListViewModel _refresh(
    UsersListViewModel state, RefreshUsersListAction action) {
  return state.copyWith(
      isLoading: false, isRefreshing: true, isLoadingMore: false);
}

UsersListViewModel _loadMore(
    UsersListViewModel state, LoadMoreUsersAction action) {
  return state.copyWith(
      isLoading: false, isRefreshing: false, isLoadingMore: true);
}

UsersListViewModel _loadMoreSuccess(
    UsersListViewModel state, GetMoreUsersSucceedAction action) {
  List<User> newList = state.usersList ?? [];
  newList.addAll(action.usersList);

  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isLoadingMore: false,
      usersList: newList);
}

UsersListViewModel _errorHandler(
    UsersListViewModel state, GetUsersListErrorAction action) {
  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isLoadingMore: false,
      isError: true,
      errorMessage: action.errorMessage);
}
