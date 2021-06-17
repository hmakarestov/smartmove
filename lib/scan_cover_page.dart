import 'package:flutter/material.dart';
import 'constraints.dart';
import 'available_games.dart';
import 'players.dart';

class ScanCoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Players(),
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
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 372,
                height: 372,
                child: Image.asset('assets/images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please scan your SmartMove' +
                        '\n' +
                        'wristbands on the reader',
                    style: TextStyle(
                      fontSize: 48.0 * 2,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.bluetooth_audio,
                color: Colors.white,
                size: 600.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AvailableGames(hasBeaconScanned: false),
                    ),
                  );
                },
                child: Text(
                  "I don't have a SmartMove wristband",
                  style: TextStyle(
                    fontSize: 34.0 * 2,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
