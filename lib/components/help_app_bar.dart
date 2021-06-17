import 'package:flutter/material.dart';
import '../constraints.dart';

class HelpAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  HelpAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(450.0),
  }) : super(key: key);

  @override
  _HelpAppBarState createState() => _HelpAppBarState();
}

class _HelpAppBarState extends State<HelpAppBar> {
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
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Help',
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
