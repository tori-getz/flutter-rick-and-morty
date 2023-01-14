import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';

abstract class AbstractCharacterRepository {
  Future<Either<AbstractFailure, List<CharacterEntity>>> getAllCharacters(
      int page);
  Future<Either<AbstractFailure, List<CharacterEntity>>> searchCharacter(
      String name);
}
