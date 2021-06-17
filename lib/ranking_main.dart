import 'package:flutter/material.dart';
import 'components/ranking_main_app_bar.dart';
import 'constraints.dart';
import 'datamodels/game.dart';
import 'ranking_detailed.dart';
import 'utils/icons_helper.dart';

class Ranking extends StatefulWidget {
  final List<Game> games;

  const Ranking({Key key, @required this.games}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return Scaffold(
      appBar: RankingMainAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.games.length,
          itemBuilder: (context, index) {
            Game game = widget.games[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailedRanking(
                      gameId: game.id,
                      gameName: game.name,
                    ),
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
                          offset: Offset(1, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    width: screenSize().width - 200,
                    height: 132.0 * 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: Icon(
                            IconsHelper.getIconByName(game.iconName),
                            size: 120.0,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          game.name,
                          style: TextStyle(
                            fontSize: 34.0 * 2,
                            fontWeight: FontWeight.bold,
                            color: kMainOrange,
                          ),
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
      ),
    );
  }
}
