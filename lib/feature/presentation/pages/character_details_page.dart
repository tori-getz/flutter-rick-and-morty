import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/cached_image.dart';

class CharacterDetailPage extends StatelessWidget {
  static const String route = '/detail';

  const CharacterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    CharacterEntity character = settings.arguments as CharacterEntity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(character.name,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            CachedImage(
              width: 260,
              height: 260,
              imageUrl: character.image,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: character.status == 'Alive'
                          ? Colors.green
                          : Colors.red),
                ),
                const SizedBox(width: 8),
                Text(
                  "${character.status} - ${character.species}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            const SizedBox(height: 16),
            if (character.type.isNotEmpty)
              ...buildText('Type:', character.type),
            ...buildText('Gender:', character.gender),
            ...buildText(
                'Number of episodes:', character.episode.length.toString()),
            ...buildText('Species:', character.species),
            ...buildText('Last known location:', character.location.name),
            ...buildText('Origin:', character.origin.name),
            ...buildText('Was created:', character.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
