import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 8)
class Photo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int albumId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
