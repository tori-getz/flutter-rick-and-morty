import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/domain/usecases/get_all_characters.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_state.dart';

class CharacterListCubit extends Cubit<CharacterState> {
  final GetAllCharacters getAllCharacters;

  CharacterListCubit({required this.getAllCharacters})
      : super(CharacterEmpty());

  int page = 1;
  void loadCharacter() async {
    if (state is CharacterLoading) return;

    final currentState = state;

    List<CharacterEntity> oldCharacters = [];
    if (currentState is CharacterLoaded) {
      oldCharacters = currentState.characters;
    }

    emit(CharacterLoading(oldCharacters, isFirstFetch: page == 1));

    final failureOrCharacters =
        await getAllCharacters(GetAllCharactersParams(page: page));

    failureOrCharacters.fold(
      (failure) {
        emit(CharacterError(_getFailureMessage(failure)));
      },
      (nextCharacters) {
        page++;
        final characters = (state as CharacterLoading).oldCharacters;
        characters.addAll(nextCharacters);
        emit(CharacterLoaded(characters));
      },
    );
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
