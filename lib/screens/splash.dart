import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/screens/home.dart';
import 'package:snd_events/screens/login.dart';
import 'package:snd_events/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (t) {
      Repository().loadPrefs().then((map) {
        if (map.containsKey(Constants.USER_TOKEN) &&
            map[Constants.USER_TOKEN] != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        token: map[Constants.USER_TOKEN],
                      )));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      });
      print("Loaded Page");
      t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                Constants.APP_NAME,
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      )),
    );
  }
}
