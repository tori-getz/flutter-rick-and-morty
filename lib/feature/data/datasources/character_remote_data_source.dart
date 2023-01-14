import 'package:flutter_rick_and_morty/core/error/exception.dart';
import 'package:flutter_rick_and_morty/core/http_client.dart';
import 'package:flutter_rick_and_morty/feature/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters(int page);
  Future<List<CharacterModel>> searchCharacter(String name);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final HttpClient client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters(int page) async {
    final response = await client.get('/character/?page=$page');

    if (response.statusCode == 200) {
      return (response.data['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacter(String name) async {
    final response = await client.get('/character/?name=$name');

    if (response.statusCode == 200) {
      return (response.data['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
