// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:flutter_social_demo/redux/actions/posts_actions.dart';
import 'package:flutter_social_demo/screens/posts/view_model/post_detail_view_model.dart';

final postDetailReducer = combineReducers<PostDetailViewModel>([
  TypedReducer<PostDetailViewModel, GetPostDetailSuccessAction>(_fetch),
  TypedReducer<PostDetailViewModel, PostErrorAction>(_errorHandler),
]);

PostDetailViewModel _fetch(
    PostDetailViewModel state, GetPostDetailSuccessAction action) {
  return state.copyWith(isLoading: false, post: action.data);
}

PostDetailViewModel _errorHandler(
    PostDetailViewModel state, PostErrorAction action) {
  return state.copyWith(
      isLoading: false, isError: true, errorMessage: action.errorMessage);
}
