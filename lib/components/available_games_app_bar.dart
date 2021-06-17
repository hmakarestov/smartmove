import 'package:flutter/material.dart';
import '../datamodels/game.dart';
import '../help_page.dart';
import '../constraints.dart';
import '../ranking_main.dart';

class AvailableGamesAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool hasBeaconScanned;
  final List<Game> games;

  AvailableGamesAppBar({
    Key key,
    this.preferredSize = const Size.fromHeight(450.0),
    this.hasBeaconScanned,
    this.games,
  }) : super(key: key);

  @override
  _AvailableGamesAppBarState createState() => _AvailableGamesAppBarState();
}

class _AvailableGamesAppBarState extends State<AvailableGamesAppBar> {
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
                    Icons.logout,
                  ),
                  iconSize: 80.0,
                  color: Colors.white,
                  onPressed: () {
                    if (widget.hasBeaconScanned) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
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
                        builder: (context) => Ranking(games: widget.games),
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
                    'Available Games',
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
        ],
      ),
    );
  }
}
