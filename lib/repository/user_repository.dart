import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class UserRepository {
  final UserApi _userApi = UserApi();

  Future<List<User>> getUsersList({int? page}) async {
    try {
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
        data = await _userApi.getList();

        // cache time and users list
        CachingService.cacheUserList(list: data);
        CachingService.setCachingTime(
            key: PreferenceKey.userListCacheTime, time: DateTime.now());
      }

      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
