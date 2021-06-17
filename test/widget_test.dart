import 'package:flutter_beacon_example/datamodels/game.dart';
import 'package:flutter_beacon_example/datamodels/player.dart';
import 'package:flutter_beacon_example/datamodels/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // testWidgets('appBar test', (WidgetTester tester) async {
  //   await tester.pumpWidget(GameDetailsAppBar(
  //     game: new Game(
  //         id: 'towergame',
  //         name: 'Tower Game',
  //         playerAmount: '5',
  //         timeDuration: 5,
  //         category: 'Arcade',
  //         url: 'http://www.google.bg',
  //         iconName: 'games'),
  //   ));
  //
  //   final titleFinder = find.text('Tower Game');
  //   final categoryFinder = find.text('Arcade');
  //   final playerAmountFinder = find.text('5');
  //
  //   expect(titleFinder, findsOneWidget);
  //   expect(categoryFinder, findsOneWidget);
  //   expect(playerAmountFinder, findsOneWidget);
  // });
  test('gameResults_parseFromJSON', () async{
    final List<Result> results = await fetchResults();

    expect(results[0].gameId, 'towergame');
    expect(results[2].gameId, 'pacman');
  });
  test('games_parseFromJSON', () async{
    final List<Game> games = await fetchGames();

    expect(games[0].id, 'towergame');
    expect(games[1].id, 'pacman');
  });
  test('players_parseFromJSON', () async{
    final List<Player> players = await fetchPlayers();

    expect(players[0].name, 'Hristo');
    expect(players[1].name, 'Koen');
  });
}
