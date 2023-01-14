import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LocationEntity {
  final String name;
  final String url;

  LocationEntity({
    required this.name,
    required this.url,
  });
}
