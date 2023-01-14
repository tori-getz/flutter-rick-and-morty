import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/feature/domain/entities/character_entity.dart';
import 'package:flutter_rick_and_morty/feature/presentation/pages/character_details_page.dart';
import 'package:flutter_rick_and_morty/feature/presentation/widgets/cached_image.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CharacterDetailPage.route,
            arguments: character);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            CachedImage(imageUrl: character.image, width: 160, height: 160),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
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
                  const SizedBox(height: 12),
                  const Text(
                    'Last known location:',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    character.location.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 4),
                  const Text(
                    'Origin:',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    character.origin.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
