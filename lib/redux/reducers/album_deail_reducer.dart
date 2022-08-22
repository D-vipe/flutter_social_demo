// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:flutter_social_demo/redux/actions/album_actions.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_detail_view_model.dart';

final albumDetailReducer = combineReducers<AlbumDetailViewModel>([
  TypedReducer<AlbumDetailViewModel, GetAlbumDetailSuccessAction>(_fetch),
  TypedReducer<AlbumDetailViewModel, AlbumErrorAction>(_errorHandler),
]);

AlbumDetailViewModel _fetch(
    AlbumDetailViewModel state, GetAlbumDetailSuccessAction action) {
  return state.copyWith(isLoading: false, album: action.data);
}

AlbumDetailViewModel _errorHandler(
    AlbumDetailViewModel state, AlbumErrorAction action) {
  return state.copyWith(
      isLoading: false, isError: true, errorMessage: action.errorMessage);
}
