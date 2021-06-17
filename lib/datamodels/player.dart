import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Player {
  final String id;
  final String name;

  Player({
    this.id,
    this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
    );
  }
}

List<Player> _parsePlayers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Player>((json) => Player.fromJson(json)).toList();
}

Future<List<Player>> fetchPlayers() async {
  final response = await rootBundle.loadString('assets/players.json');

  return compute(_parsePlayers, response.toString());
}
