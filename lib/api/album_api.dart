import 'package:dio/dio.dart';
import 'package:flutter_social_demo/app/config/dio_settings.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/config/path.dart';
import 'package:flutter_social_demo/repository/models/album_model.dart';
import 'package:flutter_social_demo/repository/models/photo_model.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class AlbumApi {
  final Dio _dio;
  final String _baseUrl = DioSettings.baseUrl;
  final String _albumsPath = Path.albumList;
  final String _photosPath = Path.photosList;

  AlbumApi({
    Dio? dio,
  }) : _dio = dio ?? DioSettings.createDio();

  Future<List<Album>> getList() async {
    // assume at this step we ought to have this id
    final String userId = SharedStorageService.getString(PreferenceKey.userId);

    try {
      Response response =
          await _dio.get('$_baseUrl$_albumsPath?userId=$userId');

      return _parseListResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  Future<List<Photo>> getPhotos({required List<int> albumIds}) async {
    try {
      String queryParam =
          albumIds.map((id) => 'albumId=$id').toList().join('&');

      Response response = await _dio.get('$_baseUrl$_photosPath?$queryParam');

      return _parsePhotosListResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  Future<Album?> getAlbumData({required int id}) async {
    try {
      Response response = await _dio.get('$_baseUrl$_albumsPath/$id');

      return _parseDetailResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  List<Album> _parseListResponse(Response response) {
    List<Album> postList = [];

    if (response.data != null || response.data.isNotEmpty) {
      try {
        for (var item in response.data) {
          postList.add(Album.fromJson(item));
        }
      } catch (e) {
        throw ParseException();
      }
    }

    return postList;
  }

  List<Photo> _parsePhotosListResponse(Response response) {
    List<Photo> commentList = [];

    if (response.data != null || response.data.isNotEmpty) {
      try {
        for (var item in response.data) {
          commentList.add(Photo.fromJson(item));
        }
      } catch (e) {
        throw ParseException();
      }
    }

    return commentList;
  }

  Album? _parseDetailResponse(Response response) {
    Album? postData;

    if (response.data != null || response.data.isNotEmpty) {
      try {
        postData = Album.fromJson(response.data);
      } catch (e) {
        throw ParseException();
      }
    }

    return postData;
  }
}
