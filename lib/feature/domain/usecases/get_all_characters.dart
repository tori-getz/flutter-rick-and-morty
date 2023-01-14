import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/core/usecase/usecase.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart';

class GetAllCharacters
    extends AbstractUseCase<List<CharacterEntity>, GetAllCharactersParams> {
  final AbstractCharacterRepository characterRepository;

  GetAllCharacters({required this.characterRepository});

  @override
  call(GetAllCharactersParams params) async {
    return characterRepository.getAllCharacters(params.page);
  }
}

class GetAllCharactersParams extends Equatable {
  final int page;

  const GetAllCharactersParams({required this.page});

  @override
  List<Object?> get props => [page];
}
