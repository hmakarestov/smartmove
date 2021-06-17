import 'package:flutter/material.dart';
import 'components/ranking_app_bar.dart';
import 'constraints.dart';
import 'datamodels/player.dart';
import 'datamodels/result.dart';

class DetailedRanking extends StatefulWidget {
  final String gameId;
  final String gameName;

  const DetailedRanking({Key key, @required this.gameId, this.gameName})
      : super(key: key);

  @override
  _DetailedRankingState createState() => _DetailedRankingState();
}

class _DetailedRankingState extends State<DetailedRanking>
    with SingleTickerProviderStateMixin {
  List<Result> results = [];
  List<Player> players = [];
  List<Result> selectedAllTimeResults = [];
  List<Result> selectedCurrentResults = [];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    loadResults();
    loadPlayers();
  }

  void loadResults() async {
    List<Result> r = await fetchResults();
    setState(() {
      results = r;
    });
    loadAllTimeResults(widget.gameId);
    loadCurrentResults(widget.gameId, "20210608-180000-B");
    selectedAllTimeResults.sort((a, b) => a.result.compareTo(b.result));
    selectedCurrentResults.sort((a, b) => a.result.compareTo(b.result));
  }

  void loadPlayers() async {
    List<Player> p = await fetchPlayers();
    setState(() {
      players = p;
    });
  }

  void loadAllTimeResults(String id) {
    results.forEach((element) {
      if (element.gameId == id) {
        selectedAllTimeResults.add(element);
      }
    });
  }

  void loadCurrentResults(String gId, String sId) {
    results.forEach((element) {
      if (element.gameId == gId && element.gameSessionId == sId) {
        selectedCurrentResults.add(element);
      }
    });
  }

  String findName(String playerId) {
    Player player = players.firstWhere((element) => element.id == playerId,
        orElse: () => null);
    if (player != null) return player.name;
    return playerId;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return Scaffold(
      appBar: RankingAppBar(
        tabController: tabController,
        title: widget.gameName,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          selectedCurrentResults.length != 0
              ? ListView.separated(
                  //current
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  shrinkWrap: true,
                  itemCount: selectedCurrentResults.length,
                  itemBuilder: (context, index) {
                    Result result = selectedCurrentResults[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) => CurrentRanking(),
                        //       ),
                        // );
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
                                  offset: Offset(
                                      1, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            width: screenSize().width - 200,
                            height: 80.0 * 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  (index + 1).toString() + ".",
                                  style: TextStyle(
                                    fontSize: 45.0 * 2,
                                    fontWeight: FontWeight.bold,
                                    color: kMainOrange,
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 120.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Container(
                                  width: 700,
                                  child: Text(
                                    findName(result.playerId),
                                    style: TextStyle(
                                      fontSize: 34.0 * 2,
                                      fontWeight: FontWeight.bold,
                                      color: kMainOrange,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  result.result,
                                  style: TextStyle(
                                    fontSize: 34.0 * 2,
                                    fontWeight: FontWeight.normal,
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
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.military_tech,
                        color: Colors.grey,
                        size: 380.0,
                      ),
                      Text(
                        "No current results available",
                        style: TextStyle(
                          fontSize: 40.0 * 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
          ListView.separated(
            //all-time
            padding: EdgeInsets.symmetric(vertical: 50.0),
            shrinkWrap: true,
            itemCount: selectedAllTimeResults.length,
            itemBuilder: (context, index) {
              Result result = selectedAllTimeResults[index];
              return GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => CurrentRanking(),
                  //       ),
                  // );
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
                      height: 80.0 * 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            (index + 1).toString() + ".",
                            style: TextStyle(
                              fontSize: 45.0 * 2,
                              fontWeight: FontWeight.bold,
                              color: kMainOrange,
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            child: Icon(
                              Icons.account_circle,
                              size: 120.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 700,
                            child: Text(
                              findName(result.playerId),
                              style: TextStyle(
                                fontSize: 34.0 * 2,
                                fontWeight: FontWeight.bold,
                                color: kMainOrange,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            result.result,
                            style: TextStyle(
                              fontSize: 34.0 * 2,
                              fontWeight: FontWeight.normal,
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
        ],
      ),
    );
  }
}
