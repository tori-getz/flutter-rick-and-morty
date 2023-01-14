import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_state.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/character_card.dart';

class CharactersList extends StatelessWidget {
  CharactersList({super.key});

  final controller = ScrollController();

  void setupScrollContoller(BuildContext context) {
    controller.addListener(() {
      if (!controller.position.atEdge) return;
      if (controller.position.pixels == 0) return;

      context.read<CharacterListCubit>().loadCharacter();
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollContoller(context);
    return BlocBuilder<CharacterListCubit, CharacterState>(
      builder: (context, state) {
        List<CharacterEntity> characters = [];
        bool isLoading = false;

        if (state is CharacterLoading && state.isFirstFetch) {
          return _loadingIndicator();
        }

        if (state is CharacterLoading) {
          characters = state.oldCharacters;
          isLoading = true;
        }

        if (state is CharacterLoaded) {
          characters = state.characters;
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<CharacterListCubit>().refresh();
          },
          child: ListView.builder(
            controller: controller,
            itemCount: characters.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == characters.length) {
                Timer(const Duration(microseconds: 30), () {
                  controller.jumpTo(controller.position.maxScrollExtent);
                });
                return _loadingIndicator();
              }

              CharacterEntity character = characters[index];
              return CharacterCard(character: character);
            },
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
