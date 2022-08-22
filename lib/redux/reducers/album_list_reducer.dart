// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/album_model.dart';
import 'package:flutter_social_demo/redux/actions/album_actions.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_list_view_model.dart';

final albumListReducer = combineReducers<AlbumListViewModel>([
  TypedReducer<AlbumListViewModel, GetAlbumListSucceedAction>(_fetch),
  TypedReducer<AlbumListViewModel, GetAlbumsProfileAction>(_profile),
  TypedReducer<AlbumListViewModel, RefreshAlbumListAction>(_refresh),
  TypedReducer<AlbumListViewModel, AlbumErrorAction>(_errorHandler),
]);

AlbumListViewModel _fetch(
    AlbumListViewModel state, GetAlbumListSucceedAction action) {
  List<Album> updatedList = List<Album>.from(action.albumsList);
  List<Album> cutList = [];

  for (var i = 0; i < 3; i++) {
    cutList.add(updatedList[i]);
  }

  return state.copyWith(
    isLoading: false,
    isRefreshing: false,
    albumList: updatedList,
    albumListProfile: cutList,
  );
}

AlbumListViewModel _profile(
    AlbumListViewModel state, GetAlbumsProfileAction action) {
  return state.copyWith(
    isLoading: true,
  );
}

AlbumListViewModel _refresh(
    AlbumListViewModel state, RefreshAlbumListAction action) {
  return state.copyWith(
    isLoading: false,
    isRefreshing: true,
  );
}

AlbumListViewModel _errorHandler(
    AlbumListViewModel state, AlbumErrorAction action) {
  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isError: true,
      errorMessage: action.errorMessage);
}
