import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';

abstract class CharacterSearchState extends Equatable {
  const CharacterSearchState();

  @override
  List<Object?> get props => [];
}

class CharacterEmpty extends CharacterSearchState {}

class CharacterSearchLoading extends CharacterSearchState {}

class CharacterSearchLoaded extends CharacterSearchState {
  final List<CharacterEntity> characters;

  const CharacterSearchLoaded({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class CharacterSearchError extends CharacterSearchState {
  final String message;

  const CharacterSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
