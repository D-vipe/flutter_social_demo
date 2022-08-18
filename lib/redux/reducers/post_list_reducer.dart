import 'package:flutter_social_demo/api/models/post_model.dart';
import 'package:flutter_social_demo/redux/actions/posts_actions.dart';
import 'package:flutter_social_demo/screens/posts/view_model/posts_view_model.dart';
import 'package:redux/redux.dart';

final postListReducer = combineReducers<PostsViewModel>([
  TypedReducer<PostsViewModel, GetPostListSucceedAction>(_fetch),
  TypedReducer<PostsViewModel, RefreshPostListAction>(_refresh),
  TypedReducer<PostsViewModel, PostErrorAction>(_errorHandler),
]);

PostsViewModel _fetch(PostsViewModel state, GetPostListSucceedAction action) {
  List<Post> updatedList = List<Post>.from(action.postList);

  return state.copyWith(
      isLoading: false, isRefreshing: false, postList: updatedList);
}

PostsViewModel _refresh(PostsViewModel state, RefreshPostListAction action) {
  return state.copyWith(
    isLoading: false,
    isRefreshing: true,
  );
}

PostsViewModel _errorHandler(PostsViewModel state, PostErrorAction action) {
  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isError: true,
      errorMessage: action.errorMessage);
}
