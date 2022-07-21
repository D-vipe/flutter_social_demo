import 'package:flutter_social_demo/api/user_api.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';

class UserRepository {
  final UserApi _userApi = UserApi();

  Future<List<User>> getUsersList({int? page}) async {
    try {
      List<User> data = await _userApi.getList();
      return data;
    } on ParseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
