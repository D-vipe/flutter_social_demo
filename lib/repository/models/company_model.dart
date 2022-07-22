// Package imports:
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Company extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String catchPhrase;
  @HiveField(2)
  final String bs;

  Company({required this.name, required this.bs, required this.catchPhrase});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
