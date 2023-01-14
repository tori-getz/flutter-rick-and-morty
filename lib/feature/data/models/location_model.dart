import 'package:flutter_rick_and_morty/feature/domain/entities/location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/location_model.g.dart';

@JsonSerializable()
class LocationModel extends LocationEntity {
  LocationModel({
    required super.name,
    required super.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
