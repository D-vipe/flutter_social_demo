// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/comment_model.dart';
import 'package:flutter_social_demo/api/models/post_model.dart';
import 'package:flutter_social_demo/app/config/dio_settings.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/config/path.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';

class PostsApi {
  final Dio _dio;
  final String _baseUrl = DioSettings.baseUrl;
  final String _postsPath = Path.postList;
  final String _commentsPath = Path.commentList;

  PostsApi({
    Dio? dio,
  }) : _dio = dio ?? DioSettings.createDio();

  Future<List<Post>> getList() async {
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

  Future<List<Comment>> getComments({required int postId}) async {
    try {
      Response response =
          await _dio.get('$_baseUrl$_commentsPath?postId=$postId');

      return _parseCommentsListResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  Future<Post?> getPostData({required int id}) async {
    try {
      Response response = await _dio.get('$_baseUrl$_postsPath/$id');

      return _parseDetailResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  Future<Comment?> addComment(
      {required int postId,
      required String name,
      required String email,
      required String body}) async {
    try {
      var response = await _dio.post(
        _baseUrl + _commentsPath,
        data: {
          'postId': postId,
          'name': name,
          'email': email,
          'body': body,
        },
      );
      return _parseAddCommentResponse(response);
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

  List<Comment> _parseCommentsListResponse(Response response) {
    List<Comment> commentList = [];

    if (response.data != null || response.data.isNotEmpty) {
      try {
        for (var item in response.data) {
          commentList.add(Comment.fromJson(item));
        }
      } catch (e) {
        throw ParseException();
      }
    }

    return commentList;
  }

  Post? _parseDetailResponse(Response response) {
    Post? postData;

    if (response.data != null || response.data.isNotEmpty) {
      try {
        postData = Post.fromJson(response.data);
      } catch (e) {
        throw ParseException();
      }
    }

    return postData;
  }

  Comment? _parseAddCommentResponse(Response response) {
    Comment? data;

    if (response.data != null || response.data.isNotEmpty) {
      try {
        data = Comment.fromJson(response.data);
      } catch (e) {
        throw ParseException();
      }
    }

    return data;
  }
}
