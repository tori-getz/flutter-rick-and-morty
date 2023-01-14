import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterEmpty extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<CharacterEntity> oldCharacters;
  final bool isFirstFetch;

  const CharacterLoading(this.oldCharacters, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldCharacters];
}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  const CharacterLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object?> get props => [message];
}
