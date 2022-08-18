import 'package:flutter_social_demo/api/post_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/api/models/post_model.dart';
import 'package:flutter_social_demo/redux/actions/posts_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:redux/redux.dart';

final PostsApi _postsApi = PostsApi();

List<Middleware<AppState>> createPostsMiddleware() {
  return [
    TypedMiddleware<AppState, GetPostListAction>(
        _fetchPostsList(refresh: false)),
    TypedMiddleware<AppState, RefreshPostListAction>(
        _fetchPostsList(refresh: true)),
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
