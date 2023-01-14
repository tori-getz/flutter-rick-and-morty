import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morty/core/error/exception.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';
import 'package:flutter_rick_and_morty/core/networking/network_info.dart';
import 'package:flutter_rick_and_morty/feature/data/datasources/character_local_data_source.dart';
import 'package:flutter_rick_and_morty/feature/data/datasources/character_remote_data_source.dart';
import 'package:flutter_rick_and_morty/feature/data/models/character_model.dart';
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  getAllCharacters(int page) async {
    return _getCharacters(() {
      return remoteDataSource.getAllCharacters(page);
    });
  }

  @override
  searchCharacter(String name) {
    return _getCharacters(() async {
      return remoteDataSource.searchCharacter(name);
    });
  }

  Future<Either<Failure, List<CharacterModel>>> _getCharacters(
      Future<List<CharacterModel>> Function() getCharacters) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await getCharacters();
        await localDataSource.setCharacters(remoteCharacters);
        return Right(remoteCharacters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacters = await localDataSource.getCharacters();

        return Right(localCharacters);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
