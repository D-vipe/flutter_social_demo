import 'package:json_annotation/json_annotation.dart';

part 'geo_location_model.g.dart';

@JsonSerializable()
class GeoLocation {
  final String lat, lng;
  GeoLocation({required this.lat, required this.lng});

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
