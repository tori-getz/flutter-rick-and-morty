import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_state.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/character_search_delegate.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/characters_list.dart';

class CharactersPage extends StatelessWidget {
  static const String route = '/';

  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          BlocBuilder<CharacterListCubit, CharacterState>(
            builder: (context, state) {
              if (state is CharacterLoaded) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CharacterSearchDelegate(
                          suggestions: state.characters),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          )
        ],
      ),
      body: CharactersList(),
    );
  }
}
