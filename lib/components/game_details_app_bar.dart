import 'package:flutter/material.dart';
import 'package:flutter_beacon_example/datamodels/game.dart';
import '../constraints.dart';
import '../help_page.dart';
import '../ranking_detailed.dart';

class GameDetailsAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Game game;

  GameDetailsAppBar({
    Key key,
    this.preferredSize = const Size.fromHeight(450.0),
    this.game,
  }) : super(key: key);

  @override
  _GameDetailsAppBarState createState() => _GameDetailsAppBarState();
}

class _GameDetailsAppBarState extends State<GameDetailsAppBar> {
  void _navigateToSettings() {
    /// TODO
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 22.0,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(134.0),
        bottomRight: Radius.circular(134.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kPrimaryColor,
                    kSecondaryColor,
                  ],
                ),
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(134.0),
                    bottomRight: const Radius.circular(134.0)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 50.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  iconSize: 80.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.bar_chart,
                  ),
                  iconSize: 80.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailedRanking(
                            gameId: widget.game.id, gameName: widget.game.name),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.help,
                  ),
                  iconSize: 80.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Help(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.game.name,
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.sports_soccer_outlined,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.game.category,
                        style: TextStyle(
                          fontSize: 24.0 * 2,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.game.playerAmount,
                        style: TextStyle(
                          fontSize: 24.0 * 2,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.game.timeDuration.toString() + " minutes",
                        style: TextStyle(
                          fontSize: 24.0 * 2,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
