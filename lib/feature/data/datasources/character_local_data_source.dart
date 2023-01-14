import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_rick_and_morty/core/constants.dart';
import 'package:flutter_rick_and_morty/core/error/exception.dart';
import 'package:flutter_rick_and_morty/feature/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<void> setCharacters(List<CharacterModel> characters);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CharacterModel>> getCharacters() {
    final jsonCharacters =
        sharedPreferences.getStringList(Constants.charactersCacheKey);

    if (jsonCharacters!.isEmpty) throw CacheException();

    return Future.value(jsonCharacters
        .map(((character) => CharacterModel.fromJson(jsonDecode(character))))
        .toList());
  }

  @override
  Future<void> setCharacters(List<CharacterModel> characters) {
    final jsonCharacters =
        characters.map((character) => jsonEncode(character.toJson())).toList();

    sharedPreferences.setStringList(
        Constants.charactersCacheKey, jsonCharacters);

    if (kDebugMode) {
      print(
          'write ${jsonCharacters.length} characters to ${Constants.charactersCacheKey}');
    }

    return Future.value(jsonCharacters);
  }
}
