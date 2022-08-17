import 'package:flutter/foundation.dart';
import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/models/models.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:flutter_social_demo/redux/app_state.dart';

final UserApi _userApi = UserApi();

List<Middleware<AppState>> createUsersListMiddleware() {
  return [
    TypedMiddleware<AppState, GetUsersListAction>(
        _fetchUsersList(refresh: false)),
    TypedMiddleware<AppState, RefreshUsersListAction>(
        _fetchUsersList(refresh: true)),
    TypedMiddleware<AppState, LoadMoreUsersAction>(_loadMoreUsers()),
  ];
}

Middleware<AppState> _fetchUsersList({required bool refresh}) {
  return (Store<AppState> store, action, NextDispatcher next) {
    // Use caching service to reduce amount of server-requests
    List<User> data = [];
    bool needToFetch = true;

    // check caching time
    if (!CachingService.needToSendRequest(
        key: PreferenceKey.userListCacheTime)) {
      // check if Hive is not empty
      data = CachingService.getCachedUsers();
      needToFetch = data.isEmpty;
    }

    if (needToFetch) {
      // cache time and users list
      _userApi.getList().then((List<User> users) {
        CachingService.cacheUserList(list: users);
        CachingService.setCachingTime(
            key: PreferenceKey.userListCacheTime, time: DateTime.now());
        store.dispatch(GetUsersListSucceedAction(usersList: users));
      }).onError((error, _) => refresh
          ? store.dispatch(GetUsersListSucceedAction(
              usersList: store.state.usersListState.usersList ?? []))
          : store.dispatch(GetUsersListErrorAction(GeneralErrors.emptyData)));
    } else {
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        refresh
            ? store.dispatch(RefreshUsersSucceedAction(usersList: data))
            : store.dispatch(GetUsersListSucceedAction(usersList: data));
      });
    }
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
