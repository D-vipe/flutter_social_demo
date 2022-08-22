import 'package:flutter_social_demo/api/album_api.dart';
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/redux/actions/album_actions.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:redux/redux.dart';

final AlbumApi _albumsApi = AlbumApi();

List<Middleware<AppState>> createAlbumMiddleware() {
  return [
    TypedMiddleware<AppState, GetAlbumListAction>(
        _fetchAlbumList(refresh: false)),
    TypedMiddleware<AppState, RefreshAlbumListAction>(
        _fetchAlbumList(refresh: true)),
    TypedMiddleware<AppState, GetAlbumsProfileAction>(
        _fetchAlbumList(refresh: false)),
    TypedMiddleware<AppState, GetAlbumDetailAction>(_fetchAlbumDetail()),
  ];
}

Middleware<AppState> _fetchAlbumList({required bool refresh}) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    Future(() async {
      try {
        // Use caching service to reduce amount of server-requests
        List<Album> data = [];
        bool needToFetch = true;

        // check caching time
        if (!CachingService.needToSendRequest(
            key: PreferenceKey.albumListCacheTime)) {
          // check if Hive is not empty
          data = CachingService.getCachedAlbums();
          needToFetch = data.isEmpty;
        }

        if (needToFetch) {
          data = await _albumsApi.getList();

          /// in order to show album preview we will fetch
          /// albums photos next
          List<int> albumIds = [];
          if (data.isNotEmpty) {
            albumIds = data.map((element) => element.id).toList();
          }

          List<Photo> allPhotos = [];
          if (albumIds.isNotEmpty) {
            allPhotos = await _albumsApi.getPhotos(albumIds: albumIds);
          }

          /// put all received photos to appropriate album to avoid
          /// further api calls so far
          if (allPhotos.isNotEmpty) {
            for (var album in data) {
              album.photos = [];
              for (var photo in allPhotos) {
                if (photo.albumId == album.id) {
                  album.photos?.add(photo);
                }
              }
            }
          }

          // cache time and users list
          CachingService.cacheAlbumList(list: data);
          CachingService.setCachingTime(
              key: PreferenceKey.albumListCacheTime, time: DateTime.now());
        }

        store.dispatch(GetAlbumListSucceedAction(albumsList: data));
      } on ParseException {
        store
            .dispatch(AlbumErrorAction(errorMessage: GeneralErrors.parseError));
      } catch (e) {
        store.dispatch(
            AlbumErrorAction(errorMessage: GeneralErrors.generalError));
      }
    });
  };
}

Middleware<AppState> _fetchAlbumDetail() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    final int albumId = action.albumId;
    Future(() async {
      try {
        Album? data;
        // First check if we have anything cached
        // If there is nothing, then fetch fresh data
        data = await HiveService.getAlbum(id: albumId);
        // if data is null
        data ??= await _albumsApi.getAlbumData(id: albumId);

        if (data?.photos == null || data!.photos!.isEmpty) {
          // get photos for current album if for some reason
          // we try to access detail with no cached data

          if (data != null) {
            List<Photo> albumPhotos = await getAlbumPhotos(albumId: data.id);
            data.photos = albumPhotos;

            // save received object to HiveBox
            data.save();
          }
        }

        store.dispatch(GetAlbumDetailSuccessAction(data: data!));
      } on ParseException {
        store
            .dispatch(AlbumErrorAction(errorMessage: GeneralErrors.parseError));
      } catch (e) {
        store.dispatch(
            AlbumErrorAction(errorMessage: GeneralErrors.generalError));
      }
    });
  };
}

Future<List<Photo>> getAlbumPhotos({required int albumId}) async {
  try {
    List<Photo> photos = [];
    // if data is null
    photos = await _albumsApi.getPhotos(albumIds: [albumId]);

    return photos;
  } on ParseException {
    rethrow;
  } catch (e) {
    rethrow;
  }
}
