import 'package:flutter_rick_and_morty/core/http_client.dart';
import 'package:flutter_rick_and_morty/core/platform/network_info.dart';
import 'package:flutter_rick_and_morty/feature/data/datasources/character_local_data_source.dart';
import 'package:flutter_rick_and_morty/feature/data/datasources/character_remote_data_source.dart';
import 'package:flutter_rick_and_morty/feature/data/repositories/character_repository_impl.dart';
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart';
import 'package:flutter_rick_and_morty/feature/domain/usecases/get_all_characters.dart';
import 'package:flutter_rick_and_morty/feature/domain/usecases/search_character.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc / cubit
  sl.registerFactory(() => CharacterSearchBloc(searchCharacter: sl()));
  sl.registerFactory(() => CharacterListCubit(getAllCharacters: sl()));

  // use cases
  sl.registerLazySingleton(() => SearchCharacter(characterRepository: sl()));
  sl.registerLazySingleton(() => GetAllCharacters(characterRepository: sl()));

  // repositories
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<CharacterLocalDataSource>(
      () => CharacterLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // external libraries
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<HttpClient>(() => HttpClient());
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
