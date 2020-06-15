import 'package:flutter/material.dart';
import 'package:snd_events/data/botton_nav_items.dart';
import 'package:snd_events/screens/events.dart';
import 'package:snd_events/screens/login.dart';
import 'package:snd_events/screens/register.dart';
import 'package:snd_events/screens/user_profile.dart';

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({Key key, this.token}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: [
          EventListScreen(userToken: widget.token),
          RegisterScreen(),
          LoginScreen(),
          UserProfileScreen(userToken: widget.token),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          // comment this to hide bottom titles
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: allDestinations.map((destination) {
            return BottomNavigationBarItem(
                icon: Icon(destination.icon),
                backgroundColor: destination.color,
                title: Text(destination.title));
          }).toList(),
        ),
      ),
    );
  }
}
