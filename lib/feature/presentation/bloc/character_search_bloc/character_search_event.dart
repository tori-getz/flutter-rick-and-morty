import 'package:equatable/equatable.dart';

abstract class CharacterSearchEvent extends Equatable {
  const CharacterSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchCharacters extends CharacterSearchEvent {
  final String characterName;

  const SearchCharacters(this.characterName);
}
