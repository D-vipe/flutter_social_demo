import 'package:flutter_social_demo/api/post_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class PostRepository {
  final PostsApi _postsApi = PostsApi();

  Future<List<Post>> getPostsList({int? page}) async {
    try {
      List<Post> data = [];
      bool needToFetch = true;
      // check caching time
      if (!CachingService.needToSendRequest(
          key: PreferenceKey.postListCacheTime)) {
        // check if Hive is not empty
        data = HiveService.getPosts();
        needToFetch = data.isEmpty;
      }

      if (needToFetch) {
        data = await _postsApi.getList();

        // cache time and users list
        CachingService.cachePostList(list: data);
        CachingService.setCachingTime(
            key: PreferenceKey.postListCacheTime, time: DateTime.now());
      }

      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
