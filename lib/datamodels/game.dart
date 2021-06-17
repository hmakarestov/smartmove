import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Game {
  final String id;
  final String name;
  final String playerAmount;
  final int timeDuration;
  final String category;
  final String url;
  final String iconName;
  final List<String> gameGuide;

  Game({
    this.id,
    this.name,
    this.playerAmount,
    this.timeDuration,
    this.category,
    this.url,
    this.iconName,
    this.gameGuide,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      playerAmount: json['playerAmount'],
      timeDuration: json['timeDuration'] as int,
      category: json['category'],
      url: json['url'],
      iconName: json['iconName'],
      gameGuide: List<String>.from(json['gameGuide']),
    );
  }
}

List<Game> _parseGames(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Game>((json) => Game.fromJson(json)).toList();
}

Future<List<Game>> fetchGames() async {
  final response = await rootBundle.loadString('assets/games.json');

  return compute(_parseGames, response.toString());
}
