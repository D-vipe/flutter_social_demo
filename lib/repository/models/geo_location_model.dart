// Package imports:
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_location_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class GeoLocation extends HiveObject {
  @HiveField(0)
  final String lat;
  @HiveField(1)
  final String lng;
  GeoLocation({required this.lat, required this.lng});

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
