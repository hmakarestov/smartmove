import 'package:flutter/material.dart';
import '../constraints.dart';
import '../help_page.dart';

class RankingAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final TabController? tabController;

  final String? title;

  RankingAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(450.0),
    this.tabController,
    this.title,
  }) : super(key: key);

  @override
  _RankingAppBarState createState() => _RankingAppBarState();
}

class _RankingAppBarState extends State<RankingAppBar> {
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
                    //widget.title,
                    widget.title!,
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
            child: TabBar(
              controller: widget.tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Current',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'All-time',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
