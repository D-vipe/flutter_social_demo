import 'package:dio/dio.dart';
import 'package:flutter_social_demo/app/config/dio_settings.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/config/path.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';

class UserApi {
  final Dio _dio;
  final String _baseUrl = DioSettings.baseUrl;
  final String _listPath = Path.userList;

  UserApi({
    Dio? dio,
  }) : _dio = dio ?? DioSettings.createDio();

  Future<List<User>> getList({int? page}) async {
    try {
      Response response = await _dio.get('$_baseUrl$_listPath');

      return _parseListResponse(response);
    } on ParseException {
      rethrow;
    } catch (e) {
      throw DioExceptions.fromDioError(e as DioError).message;
    }
  }

  List<User> _parseListResponse(Response response) {
    List<User> userList = [];

    if (response.data != null || response.data.isNotEmpty) {
      try {
        for (var item in response.data) {
          userList.add(User.fromJson(item));
        }
      } catch (e) {
        throw ParseException();
      }
    }

    return userList;
  }
}
