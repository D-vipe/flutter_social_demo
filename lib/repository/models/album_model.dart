// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:flutter_social_demo/repository/models/photo_model.dart';

part 'album_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class Album extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  List<Photo>? photos = [];

  Album({
    required this.id,
    required this.userId,
    required this.title,
    this.photos,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
