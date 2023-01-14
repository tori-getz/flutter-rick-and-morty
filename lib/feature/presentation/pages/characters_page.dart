import 'package:flutter/material.dart';
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: CharactersList(),
    );
  }
}
