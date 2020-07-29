import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/screens/splash.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create:(context)=> AppState()),
        ChangeNotifierProvider.value(
          value: AppState(),
        )
      ],
      child: MaterialApp(
          title: Constants.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.grey[200],
            primaryColor: AppTheme.PrimaryColor,
            primaryColorDark: AppTheme.PrimaryDarkColor,
            primaryColorLight: AppTheme.PrimaryAssentColor,
            errorColor: AppTheme.ErrorColor,
            cursorColor: AppTheme.PrimaryDarkColor,
           // primarySwatch: Colors.grey,
            // primarySwatch: const Color.fromRGBO(r, g, b, opacity),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()),
    );
  }
}
