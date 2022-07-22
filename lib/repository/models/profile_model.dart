import 'package:flutter_social_demo/repository/models/album_model.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class Profile extends HiveObject {
  @HiveField(0)
  final User user;
  @HiveField(1)
  List<Post>? posts = [];
  @HiveField(2)
  List<Album>? albums = [];

  Profile({required this.user, this.albums, this.posts});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
