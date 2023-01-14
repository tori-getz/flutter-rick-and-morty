import 'package:flutter_rick_and_morty/core/error/exception.dart';
import 'package:flutter_rick_and_morty/core/networking/http_client.dart';
import 'package:flutter_rick_and_morty/feature/data/models/character_model.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters(int page);
  Future<List<CharacterModel>> searchCharacter(String name);
}

@Injectable(as: CharacterRemoteDataSource)
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final HttpClient client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters(int page) =>
      _getCharactersFromUrl('/character/?page=$page');

  @override
  Future<List<CharacterModel>> searchCharacter(String name) =>
      _getCharactersFromUrl('/character/?name=$name');

  Future<List<CharacterModel>> _getCharactersFromUrl(String url) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return (response.data['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
