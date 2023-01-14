import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/feature/presentation/pages/characters_page.dart';

class RouteManager {
  RouteManager._();

  static String get initialRoute => CharactersPage.route;

  static Map<String, WidgetBuilder> get routes => {
        CharactersPage.route: (context) => const CharactersPage(),
      };
}
