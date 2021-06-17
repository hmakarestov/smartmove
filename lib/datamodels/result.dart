import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Result {
  final String? gameId;
  final String? playerId;
  final String? result;
  final String? gameSessionId;
  final String? location;

  Result(
      {this.gameId,
      this.playerId,
      this.result,
      this.gameSessionId,
      this.location});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        gameId: json['gameId'],
        playerId: json['playerId'],
        result: json['result'],
        gameSessionId: json['gameSessionId'],
        location: json['location']);
  }
}

List<Result> _parseResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Result>((json) => Result.fromJson(json)).toList();
}

Future<List<Result>> fetchResults() async {
  final response = await rootBundle.loadString('assets/game_results.json');

  return compute(_parseResults, response.toString());
}
