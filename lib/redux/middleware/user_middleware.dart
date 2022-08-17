import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/models/models.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_social_demo/redux/app_state.dart';

final UserApi _userApi = UserApi();

List<Middleware<AppState>> createUsersListMiddleware() {
  return [
    TypedMiddleware<AppState, GetUsersListAction>(_fetchUsersList()),
    TypedMiddleware<AppState, RefreshUsersListAction>(_refreshUsersList()),
    TypedMiddleware<AppState, LoadMoreUsersAction>(_loadMoreUsers()),
  ];
}

Middleware<AppState> _fetchUsersList() {
  // TODO implement caching service
  return (Store<AppState> store, action, NextDispatcher next) {
    _userApi.getList().then((List<User> users) {
      store.dispatch(GetUsersListSucceedAction(usersList: users));
    }).onError((error, _) =>
        store.dispatch(GetUsersListErrorAction(GeneralErrors.emptyData)));

    next(action);
  };
}

Middleware<AppState> _refreshUsersList() {
  return (Store<AppState> store, action, NextDispatcher next) {
    _userApi.getList().then((List<User> users) {
      store.dispatch(GetUsersListSucceedAction(usersList: users));
    }).onError((error, _) => store.dispatch(GetUsersListSucceedAction(
        usersList: store.state.usersListState.usersList ?? [])));

    next(action);
  };
}

// Fake load more as json service return all available users at once
Middleware<AppState> _loadMoreUsers() {
  // TODO imitate page increment upon loading
  return (Store<AppState> store, action, NextDispatcher next) {
    _userApi.getList().then((List<User> users) {
      store.dispatch(GetMoreUsersSucceedAction(usersList: users));
    }).onError((error, _) =>
        store.dispatch(GetUsersListErrorAction(GeneralErrors.emptyData)));

    next(action);
  };
}
