import 'package:flutter/material.dart';
import 'scan_cover_page.dart';
import 'constraints.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScanCoverPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor,
                kSecondaryColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 372,
                height: 372,
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Welkom bij Smartmove' + "\n",
                        style: TextStyle(
                          fontSize: 48.0 * 2,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Breda",
                            style: TextStyle(
                              fontSize: 96.0 * 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Icon(
                Icons.touch_app_rounded,
                color: Colors.white,
                size: 600.0,
              ),
              Text(
                "Tap the screen to continue",
                style: TextStyle(
                  fontSize: 34.0 * 2,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
