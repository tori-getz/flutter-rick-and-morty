import 'package:flutter_rick_and_morty/feature/data/models/location_model.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/character_model.g.dart';

@JsonSerializable()
class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required LocationModel super.origin,
    required LocationModel super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}
