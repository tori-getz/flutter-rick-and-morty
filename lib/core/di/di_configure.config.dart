// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_rick_and_morty/core/di/external_module.dart' as _i15;
import 'package:flutter_rick_and_morty/core/networking/http_client.dart' as _i3;
import 'package:flutter_rick_and_morty/core/networking/network_info.dart'
    as _i5;
import 'package:flutter_rick_and_morty/feature/data/datasources/character_local_data_source.dart'
    as _i7;
import 'package:flutter_rick_and_morty/feature/data/datasources/character_remote_data_source.dart'
    as _i8;
import 'package:flutter_rick_and_morty/feature/data/repositories/character_repository_impl.dart'
    as _i10;
import 'package:flutter_rick_and_morty/feature/domain/repositories/character_repository.dart'
    as _i9;
import 'package:flutter_rick_and_morty/feature/domain/usecases/get_all_characters.dart'
    as _i11;
import 'package:flutter_rick_and_morty/feature/domain/usecases/search_character.dart'
    as _i12;
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart'
    as _i13;
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_bloc.dart'
    as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final externalModule = _$ExternalModule();
    gh.factoryParam<_i3.HttpClient, _i4.BaseOptions?, dynamic>((
      baseOptions,
      _,
    ) =>
        _i3.HttpClient(baseOptions));
    gh.lazySingleton<_i5.NetworkInfo>(() => externalModule.networkInfo);
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => externalModule.prefs,
      preResolve: true,
    );
    gh.factory<_i7.CharacterLocalDataSource>(() =>
        _i7.CharacterLocalDataSourceImpl(
            sharedPreferences: gh<_i6.SharedPreferences>()));
    gh.factory<_i8.CharacterRemoteDataSource>(
        () => _i8.CharacterRemoteDataSourceImpl(client: gh<_i3.HttpClient>()));
    gh.lazySingleton<_i9.CharacterRepository>(
        () => _i10.CharacterRepositoryImpl(
              remoteDataSource: gh<_i8.CharacterRemoteDataSource>(),
              localDataSource: gh<_i7.CharacterLocalDataSource>(),
              networkInfo: gh<_i5.NetworkInfo>(),
            ));
    gh.lazySingleton<_i11.GetAllCharacters>(() => _i11.GetAllCharacters(
        characterRepository: gh<_i9.CharacterRepository>()));
    gh.lazySingleton<_i12.SearchCharacter>(() => _i12.SearchCharacter(
        characterRepository: gh<_i9.CharacterRepository>()));
    gh.factory<_i13.CharacterListCubit>(() =>
        _i13.CharacterListCubit(getAllCharacters: gh<_i11.GetAllCharacters>()));
    gh.factory<_i14.CharacterSearchBloc>(() =>
        _i14.CharacterSearchBloc(searchCharacter: gh<_i12.SearchCharacter>()));
    return this;
  }
}

class _$ExternalModule extends _i15.ExternalModule {}
