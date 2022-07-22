// Project imports:
import 'package:flutter_social_demo/api/album_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/repository/models/album_model.dart';
import 'package:flutter_social_demo/repository/models/photo_model.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class AlbumRepository {
  final AlbumApi _albumsApi = AlbumApi();

  Future<List<Album>> getAlbumsList() async {
    try {
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
        // in order to show album preview we will fetch
        // albums photos next
        List<int> albumIds = [];
        if (data.isNotEmpty) {
          albumIds = data.map((element) => element.id).toList();
        }

        List<Photo> allPhotos = [];
        if (albumIds.isNotEmpty) {
          allPhotos = await _albumsApi.getPhotos(albumIds: albumIds);
        }

        // put all received photos to appropriate album to avoid
        // further api calls so far
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

      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Album?> getAlbumDetail({required int albumId}) async {
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

      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
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
}
