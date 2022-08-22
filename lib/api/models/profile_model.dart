// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/user_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class Profile extends HiveObject {
  @HiveField(0)
  final User user;

  Profile({required this.user});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
