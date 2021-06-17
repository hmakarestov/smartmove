import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

import 'available_games.dart';
import 'constraints.dart';
import 'controller/requirement_state_controller.dart';
import 'datamodels/player.dart';

class TabScanning extends StatefulWidget {
  @override
  _TabScanningState createState() => _TabScanningState();
}

class _TabScanningState extends State<TabScanning> {
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  final controller = Get.find<RequirementStateController>();
  List<Player> players = [];

  // Map<String, String> _players = {
  //   '8BE4282F-8978-40C4-A393-909E0BB4C832': 'Hristo',
  //   'D968B104-92A8-4EEE-B77C-7482C247D30A': 'Koen',
  // };

  @override
  void initState() {
    super.initState();
    loadPlayers();
    controller.startStream.listen((flag) {
      if (flag == true) {
        initScanBeacon();
      }
    });

    controller.pauseStream.listen((flag) {
      if (flag == true) {
        pauseScanBeacon();
      }
    });
  }

  void loadPlayers() async {
    List<Player> p = await fetchPlayers();
    setState(() {
      players = p;
    });
  }

  initScanBeacon() async {
    print('==== initScanBeacon');
    await flutterBeacon.initializeScanning;
    if (!controller.authorizationStatusOk ||
        !controller.locationServiceEnabled ||
        !controller.bluetoothEnabled) {
      print(
          'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
          'locationServiceEnabled=${controller.locationServiceEnabled}, '
          'bluetoothEnabled=${controller.bluetoothEnabled}');
      return;
    }
    final regions = <Region>[
      Region(
        identifier: null,
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print(result.region.identifier);
      if (result != null && mounted) {
        setState(() {
          _regionBeacons[result.region] = result.beacons;
          _beacons.clear();
          _regionBeacons.values.forEach((list) {
            _beacons.addAll(list);
          });
          _beacons.sort(_compareParameters);
        });
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void dispose() {
    _streamRanging?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return Scaffold(
      body: _beacons == null || _beacons.isEmpty
          ? Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
                height: 200.0,
                width: 200.0,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    shrinkWrap: true,
                    itemCount: _beacons.length,
                    itemBuilder: (context, index) {
                      Beacon beacon = _beacons[index];
                      print('Found beacon: ${beacon.proximityUUID}');

                      String playerName = "Player " + (index + 1).toString();

                      for (int i = 0; i < players.length; i++) {
                        if (players[i].id == beacon.proximityUUID)
                          playerName = players[i].name;
                      }
                      // if (_players.containsKey(beacon.proximityUUID)) {
                      //   playerName = _players[beacon.proximityUUID];
                      // }

                      return GestureDetector(
                        onTap: () {},
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
                              width: screenSize().width - 50,
                              height: 132.0 * 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 120.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    playerName,
                                    style: TextStyle(
                                      fontSize: 34.0 * 2,
                                      fontWeight: FontWeight.bold,
                                      color: kMainOrange,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    beacon.proximityUUID,
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
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
                Padding(
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
                            builder: (context) =>
                                AvailableGames(hasBeaconScanned: true),
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
                        "Continue",
                        style: TextStyle(
                          fontSize: 34.0 * 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
