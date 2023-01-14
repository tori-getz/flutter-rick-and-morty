import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_state.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_bloc.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_event.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_state.dart';
import 'package:flutter_rick_and_morty/feature/presentation/pages/character_details_page.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/character_search_result.dart';

class CharacterSearchDelegate extends SearchDelegate {
  final List<CharacterEntity> suggestions;

  CharacterSearchDelegate({required this.suggestions})
      : super(searchFieldLabel: 'Search for characters...');

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query == '') {
      return [];
    }

    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<CharacterSearchBloc>(context, listen: false)
        .add(SearchCharacters(query));
    return BlocBuilder<CharacterSearchBloc, CharacterSearchState>(
      builder: (context, state) {
        print(state.toString());

        if (state is CharacterSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CharacterSearchError) {
          return _errorMessage('Not found');
        }

        if (state is CharacterSearchLoaded) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              final result = state.characters[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CharacterDetailPage.route,
                      arguments: result);
                },
                child: CharacterSearchResult(character: result),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _errorMessage(String message) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return const SizedBox.shrink();
    }

    final filteredSuggestions = suggestions
        .where((suggestion) => suggestion.name.contains(query.toString()))
        .take(5)
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        CharacterEntity suggestion = filteredSuggestions[index];
        return GestureDetector(
          onTap: () {
            query = suggestion.name;
            BlocProvider.of<CharacterSearchBloc>(context, listen: false)
                .add(SearchCharacters(query));
          },
          child: Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(suggestion.image),
              ),
              title: Text(suggestion.name),
            ),
          ),
        );
      },
    );
  }
}
