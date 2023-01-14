import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final AbstractCharacterRepository characterRepository;

  GetAllCharacters({required this.characterRepository});

  Future<Either<AbstractFailure, List<CharacterEntity>>> call(int page) async {
    return characterRepository.getAllCharacters(page);
  }
}
