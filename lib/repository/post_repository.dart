// Project imports:
import 'package:flutter_social_demo/api/post_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/models/comment_model.dart';
import 'package:flutter_social_demo/models/post_model.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class PostRepository {
  final PostsApi _postsApi = PostsApi();

  Future<List<Post>> getPostsList() async {
    try {
      List<Post> data = [];
      bool needToFetch = true;
      // check caching time
      if (!CachingService.needToSendRequest(
          key: PreferenceKey.postListCacheTime)) {
        // check if Hive is not empty
        data = CachingService.getCachedPost();
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

  Future<Post?> getPostDetail({required int postId}) async {
    try {
      Post? data;
      // First check if we have anything cached
      // If there is nothing, then fetch fresh data
      data = await HiveService.getPost(id: postId);
      // if data is null
      data ??= await _postsApi.getPostData(id: postId);

      if (data?.comments == null || data!.comments!.isEmpty) {
        // get photos for current album if for some reason
        // we try to access detail with no cached data

        if (data != null) {
          List<Comment> postComments = await getPostComments(postId: data.id);
          data.comments = postComments;

          // save received object to HiveBox
          data.save();
        }
      }

      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Comment>> getPostComments({required int postId}) async {
    try {
      List<Comment> comments = [];
      // if data is null
      comments = await _postsApi.getComments(postId: postId);

      return comments;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> addComment(
      {required int postId,
      required String name,
      required String email,
      required String body}) async {
    try {
      Comment? newComment;
      Post? post = await HiveService.getPost(id: postId);

      newComment = await _postsApi.addComment(
          postId: postId, name: name, email: email, body: body);

      if (newComment != null) {
        if (post != null && post.comments != null) {
          post.comments!.add(newComment);
          post.save();
        }
      }

      return post!;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
