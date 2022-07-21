// Package imports:
import 'package:flutter_social_demo/repository/models/address_model.dart';
import 'package:flutter_social_demo/repository/models/company_model.dart';
import 'package:flutter_social_demo/repository/models/geo_location_model.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box users;
  static late Box albums;
  static late Box posts;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(GeoLocationAdapter());

    users = await Hive.openBox<User>('users');
  }

  static List<User> getUsers() {
    return users.values.toList() as List<User>;
  }

  // put all received users into the box
  static Future<void> addUsers({required List<User> data}) async {
    // clear box first
    await users.clear();

    for (var element in data) {
      users.put(element.id, element);
    }
  }
}
