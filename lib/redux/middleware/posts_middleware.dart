// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/api/post_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/redux/actions/posts_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

final PostsApi _postsApi = PostsApi();

List<Middleware<AppState>> createPostsMiddleware() {
  return [
    TypedMiddleware<AppState, GetPostListAction>(
        _fetchPostsList(refresh: false)),
    TypedMiddleware<AppState, RefreshPostListAction>(
        _fetchPostsList(refresh: true)),
    TypedMiddleware<AppState, GetPostsProfileAction>(
        _fetchPostsList(refresh: false)),
    TypedMiddleware<AppState, GetPostDetailAction>(_fetchPostDetail()),
    TypedMiddleware<AppState, AddPostComment>(_addComment()),
  ];
}

Middleware<AppState> _fetchPostsList({required bool refresh}) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    // Use caching service to reduce amount of server-requests
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
      // cache time and users list
      _postsApi
          .getList()
          .then((List<Post> posts) {
            CachingService.cachePostList(list: posts);
            CachingService.setCachingTime(
                key: PreferenceKey.postListCacheTime, time: DateTime.now());
            store.dispatch(GetPostListSucceedAction(postList: posts));
          })
          .catchError(
            test: ((error) => error is ParseException),
            (error, _) => refresh
                ? store.dispatch(GetPostListSucceedAction(
                    postList: store.state.postsScreenState.postList ?? []))
                : store.dispatch(
                    PostErrorAction(errorMessage: GeneralErrors.parseError)),
          )
          .onError(
            (error, _) => refresh
                ? store.dispatch(GetPostListSucceedAction(
                    postList: store.state.postsScreenState.postList ?? []))
                : store.dispatch(
                    PostErrorAction(errorMessage: GeneralErrors.generalError)),
          );
    } else {
      store.dispatch(GetPostListSucceedAction(postList: data));
    }
  };
}

Middleware<AppState> _addComment() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final int postId = action.postId;
    final String name = action.name;
    final String email = action.email;
    final String body = action.comment;

    try {
      Future(() async {
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
        store.dispatch(GetPostDetailSuccessAction(data: post!));
      });
    } on ParseException {
      store.dispatch(PostErrorAction(errorMessage: GeneralErrors.parseError));
    } catch (e) {
      store.dispatch(PostErrorAction(errorMessage: GeneralErrors.generalError));
    }
  };
}

Middleware<AppState> _fetchPostDetail() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final int postId = action.postId;
    Post? data;

    Future(() async {
      try {
        // First check if we have anything cached
        // If there is nothing, then fetch fresh data
        data = await HiveService.getPost(id: postId);
        // if data is null
        data ??= await _postsApi.getPostData(id: postId);

        if (data?.comments == null || data!.comments!.isEmpty) {
          // get comments for current post if for some reason
          // we try to access detail with no cached data
          if (data != null) {
            List<Comment> postComments =
                await getPostComments(postId: data!.id);
            data!.comments = postComments;

            // save received object to HiveBox
            data!.save();
          }
        }

        store.dispatch(GetPostDetailSuccessAction(data: data!));
      } on ParseException {
        store.dispatch(PostErrorAction(errorMessage: GeneralErrors.parseError));
      } catch (e) {
        store.dispatch(
            PostErrorAction(errorMessage: GeneralErrors.generalError));
      }
    });
  };
}

Future<List<Comment>> getPostComments({required int postId}) async {
  try {
    List<Comment> comments = [];
    comments = await _postsApi.getComments(postId: postId);

    return comments;
  } on ParseException {
    rethrow;
  } catch (e) {
    rethrow;
  }
}
