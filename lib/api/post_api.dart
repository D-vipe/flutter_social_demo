import 'package:dio/dio.dart';
import 'package:flutter_social_demo/app/config/dio_settings.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/config/path.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class PostsApi {
  final Dio _dio;
  final String _baseUrl = DioSettings.baseUrl;
  final String _postsPath = Path.postList;

  PostsApi({
    Dio? dio,
  }) : _dio = dio ?? DioSettings.createDio();

  Future<List<Post>> getList({int? page}) async {
    // assume at this step we ought to have this id
    final String userId = SharedStorageService.getString(PreferenceKey.userId);

    try {
      Response response = await _dio.get('$_baseUrl$_postsPath?userId=$userId');

      return _parseListResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  List<Post> _parseListResponse(Response response) {
    List<Post> postList = [];

    if (response.data != null || response.data.isNotEmpty) {
      try {
        for (var item in response.data) {
          postList.add(Post.fromJson(item));
        }
      } catch (e) {
        throw ParseException();
      }
    }

    return postList;
  }
}
