import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/cached_image.dart';

class CharacterSearchResult extends StatelessWidget {
  final CharacterEntity character;

  const CharacterSearchResult({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          CachedImage(
            imageUrl: character.image,
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          ListTile(
            title: Text(character.name),
            subtitle: Text(character.location.name),
          )
        ],
      ),
    );
  }
}
