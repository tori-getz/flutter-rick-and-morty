import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/core/usecase/usecase.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchCharacter
    extends AbstractUseCase<List<CharacterEntity>, SearchCharacterParams> {
  final CharacterRepository characterRepository;

  SearchCharacter({required this.characterRepository});

  @override
  call(SearchCharacterParams params) async {
    return characterRepository.searchCharacter(params.name);
  }
}

class SearchCharacterParams extends Equatable {
  final String name;

  const SearchCharacterParams({required this.name});

  @override
  List<Object?> get props => [name];
}
