import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/redux/actions/profile_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:redux/redux.dart';

final UserApi _userApi = UserApi();
final String userId = SharedStorageService.getString(PreferenceKey.userId);

List<Middleware<AppState>> createProfileMiddleware() {
  return [
    TypedMiddleware<AppState, GetProfileAction>(_fetchProfile(refresh: false)),
    TypedMiddleware<AppState, RefreshProfileAction>(
        _fetchProfile(refresh: true)),
  ];
}

Middleware<AppState> _fetchProfile({required bool refresh}) {
  return (Store<AppState> store, action, NextDispatcher next) {
    try {
      Future(() async {
        Profile? profileData;
        bool needToFetch = true;
        // check caching time
        if (!CachingService.needToSendRequest(
            key: PreferenceKey.profileCacheTime)) {
          // check if Hive is not empty
          profileData =
              await CachingService.getCachedProfile(userId: int.parse(userId));
          needToFetch = profileData == null;
        }

        if (needToFetch) {
          // get user data
          final User? userData = await _userApi.getById(id: userId);
          if (userData == null) {
            throw NotFoundException;
          } else {
            profileData = Profile(user: userData);
          }

          // cache time and users list
          CachingService.cacheProfile(data: profileData);
          CachingService.setCachingTime(
              key: PreferenceKey.profileCacheTime, time: DateTime.now());
        }

        store.dispatch(GetProfileSucceedAction(data: profileData!));
      });
    } on ParseException {
      refresh
          ? store.dispatch(GetProfileSucceedAction(data: action.oldProfile))
          : store.dispatch(
              ProfileErrorAction(errorMessage: GeneralErrors.parseError));
    } catch (e) {
      refresh
          ? store.dispatch(GetProfileSucceedAction(data: action.oldProfile))
          : store.dispatch(
              ProfileErrorAction(errorMessage: GeneralErrors.generalError));
    }
    next(action);
  };
}
