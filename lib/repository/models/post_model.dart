import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Post extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
