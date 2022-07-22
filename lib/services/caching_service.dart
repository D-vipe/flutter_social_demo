import 'package:flutter_social_demo/repository/models/album_model.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class CachingService {
  // final num cachingMinutes = 30;
  static bool needToSendRequest({required PreferenceKey key}) {
    bool res = false;
    String cachingTime = SharedStorageService.getString(key);

    if (cachingTime == '') {
      res = true;
    } else {
      DateTime _now = DateTime.now();
      DateTime? _cachedTime = DateTime.tryParse(cachingTime);
      if (_cachedTime != null) {
        if (_now.difference(_cachedTime).inMinutes > 30) {
          res = true;
        } else {
          res = false;
        }
      } else {
        res = true;
      }
    }

    return res;
  }

  static Future<void> setLoggedUser() async {
    await SharedStorageService.setString(PreferenceKey.userId, '1');
  }

  static Future<void> setCachingTime(
      {required PreferenceKey key, required DateTime time}) async {
    await SharedStorageService.setString(key, time.toString());
  }

  static void cacheUserList({required List<User> list}) {
    HiveService.addUsers(data: list);
  }

  static void cachePostList({required List<Post> list}) {
    HiveService.addPosts(data: list);
  }

  static void cacheAlbumList({required List<Album> list}) {
    HiveService.addAlbums(data: list);
  }

  static List<User> getCachedUsers() {
    return HiveService.getUsers();
  }

  static List<Post> getCachedPost() {
    return HiveService.getPosts();
  }

  static List<Album> getCachedAlbums() {
    return HiveService.getAlbums();
  }
}
