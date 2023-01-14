import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';
import 'package:flutter_rick_and_morty/feature/domain/usecases/search_character.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_event.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CharacterSearchBloc
    extends Bloc<CharacterSearchEvent, CharacterSearchState> {
  final SearchCharacter searchCharacter;
  CharacterSearchBloc({required this.searchCharacter})
      : super(CharacterEmpty()) {
    on<SearchCharacters>((event, emit) async {
      final failureOrCharacters = await searchCharacter(
          SearchCharacterParams(name: event.characterName));

      failureOrCharacters.fold(
        (failure) {
          emit(CharacterSearchError(message: _getFailureMessage(failure)));
        },
        (characters) {
          emit(CharacterSearchLoaded(characters: characters));
        },
      );
    });
  }

  String _getFailureMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    }

    if (failure is CacheFailure) {
      return 'Cache Failure';
    }

    return 'Unknown error';
  }
}
