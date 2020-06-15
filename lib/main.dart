import 'package:flutter/material.dart';
import 'package:snd_events/screens/splash.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.APP_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen()
    );
  }
}

