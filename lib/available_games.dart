import 'package:flutter/material.dart';
import 'package:flutter_beacon_example/game_details.dart';
import 'package:flutter_beacon_example/utils/icons_helper.dart';
import 'components/available_games_app_bar.dart';
import 'constraints.dart';
import 'datamodels/game.dart';

class AvailableGames extends StatefulWidget {
  final bool hasBeaconScanned;

  AvailableGames({@required this.hasBeaconScanned});

  @override
  _AvailableGamesState createState() => _AvailableGamesState();
}

class _AvailableGamesState extends State<AvailableGames> {
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  void loadGames() async {
    List<Game> g = await fetchGames();
    setState(() {
      games = g;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return Scaffold(
      appBar: AvailableGamesAppBar(
          hasBeaconScanned: widget.hasBeaconScanned, games: games),
      body: widget.hasBeaconScanned == false
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: games.length,
                itemBuilder: (context, index) {
                  Game game = games[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameDetails(game: game),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(134),
                            color: kBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset:
                                    Offset(1, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          width: screenSize().width - 200,
                          height: 216.0 * 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 432,
                                height: 432,
                                child: Icon(
                                  IconsHelper.getIconByName(game.iconName),
                                  size: 250.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    game.name,
                                    style: TextStyle(
                                      fontSize: 34.0 * 2,
                                      fontWeight: FontWeight.bold,
                                      color: kMainOrange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    //game type
                                    children: [
                                      Icon(
                                        Icons.sports_soccer_outlined,
                                        size: 40.0,
                                        color: kMainOrange,
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      Text(
                                        game.category,
                                        style: TextStyle(
                                          fontSize: 24.0 * 2,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    //number of players
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 40.0,
                                        color: kMainOrange,
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      Text(
                                        game.playerAmount,
                                        style: TextStyle(
                                          fontSize: 24.0 * 2,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 40.0,
                                        color: kMainOrange,
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      Text(
                                        game.timeDuration.toString() +
                                            " minutes",
                                        style: TextStyle(
                                          fontSize: 24.0 * 2,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 60),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    color: Colors.grey,
                    size: 380.0,
                  ),
                  Text(
                    "Sorry! No games available at this moment!",
                    style: TextStyle(
                      fontSize: 40.0 * 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
