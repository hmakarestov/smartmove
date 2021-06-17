import 'package:flutter/material.dart';
import 'components/game_details_app_bar.dart';
import 'datamodels/game.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'constraints.dart';
import 'play_game.dart';

class GameDetails extends StatefulWidget {
  final Game game;

  const GameDetails({Key? key, required this.game}) : super(key: key);

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  final PageController pageController = PageController();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  bool tabsCreated = false;
  List<Widget> tabs = [];

  void addTabs(List<String> s) {
    for (int i = 0; i < s.length; i++) {
      tabs.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
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
          width: 1400.0,
          //height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Container(
                    width: 250,
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          fontSize: 34.0 * 2,
                          fontWeight: FontWeight.bold,
                          color: kMainOrange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 600,
                  ),
                  Icon(
                    Icons.menu_book,
                    color: kMainOrange,
                    size: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Guide",
                    style: TextStyle(
                      fontSize: 24.0 * 2,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                color: kLightGrey,
                thickness: 15,
                indent: 50,
                endIndent: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                child: Container(
                  child: Text(
                    s[i],
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24.0 * 2,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    tabsCreated = true;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    if (tabsCreated == false) {
      addTabs(widget.game.gameGuide!);
    }
    return Scaffold(
      appBar: GameDetailsAppBar(game: widget.game),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 1800,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                this.setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: tabs,
            carouselController: carouselController,
          ),
          SizedBox(
            height: 50,
          ),
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: tabs.length,
            effect: ScrollingDotsEffect(
              activeDotColor: kMainOrange,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: screenSize().width - 200,
                  height: 160,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlayGame(url: widget.game.url),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: MaterialStateProperty.all(kMainOrange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    primary: kMainOrange,
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 34.0 * 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
