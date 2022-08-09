// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:flutter_social_demo/models/address_model.dart';
import 'package:flutter_social_demo/models/album_model.dart';
import 'package:flutter_social_demo/models/comment_model.dart';
import 'package:flutter_social_demo/models/company_model.dart';
import 'package:flutter_social_demo/models/geo_location_model.dart';
import 'package:flutter_social_demo/models/photo_model.dart';
import 'package:flutter_social_demo/models/post_model.dart';
import 'package:flutter_social_demo/models/profile_model.dart';
import 'package:flutter_social_demo/models/user_model.dart';

class HiveService {
  static late Box users;
  static late Box albums;
  static late Box posts;
  static late Box profile;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(GeoLocationAdapter());
    Hive.registerAdapter(PostAdapter());
    Hive.registerAdapter(CommentAdapter());
    Hive.registerAdapter(AlbumAdapter());
    Hive.registerAdapter(PhotoAdapter());
    Hive.registerAdapter(ProfileAdapter());

    users = await Hive.openBox<User>('users');
    // Box for caching authed user data;
    profile = await Hive.openBox<Profile>('profile');
    posts = await Hive.openBox<Post>('posts');
    albums = await Hive.openBox<Album>('albums');
  }

  static List<User> getUsers() {
    return users.values.toList() as List<User>;
  }

  static List<Post> getPosts() {
    return posts.values.toList() as List<Post>;
  }

  static List<Album> getAlbums() {
    return albums.values.toList() as List<Album>;
  }

  // get profile by userId
  static Future<Profile?> getProfile({required int userId}) async {
    return await profile.get(userId);
  }

  // get post by id
  static Future<Post?> getPost({required int id}) async {
    return await posts.get(id);
  }

  // get album by id
  static Future<Album?> getAlbum({required int id}) async {
    return await albums.get(id);
  }

  // put all received posts into the box
  static Future<void> addPosts({required List<Post> data}) async {
    // clear box first
    await posts.clear();

    for (var element in data) {
      posts.put(element.id, element);
    }
  }

  // put all received albums into the box
  static Future<void> addAlbums({required List<Album> data}) async {
    // clear box first
    await albums.clear();

    for (var element in data) {
      albums.put(element.id, element);
    }
  }

  // put all received users into the box
  static Future<void> addUsers({required List<User> data}) async {
    // clear box first
    await users.clear();

    for (var element in data) {
      users.put(element.id, element);
    }
  }

  // put user profile into the box
  static Future<void> addProfile({required Profile data}) async {
    // clear box first
    await profile.clear();

    profile.put(data.user.id, data);
  }
}
