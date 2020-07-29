import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/data/botton_nav_items.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/screens/events.dart';
import 'package:snd_events/screens/help.dart';
import 'package:snd_events/screens/notifications.dart';
import 'package:snd_events/screens/topicslist.dart';
import 'package:snd_events/screens/user_profile.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({Key key, this.token}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  String token;
  String _profilePhoto;
  String _title = Constants.APP_NAME;
  AppState appState;
  @override
  void initState() {
    this.token = widget.token;
    if (widget.token == null || widget.token.isEmpty) {
      Repository().loadPrefs().then((prefs) {
        setState(() {
          token = prefs[Constants.USER_TOKEN];
          _profilePhoto = prefs[Constants.KEY_PROFILE_PHOTO];
        });
      });
    }
    appState = Provider.of<AppState>(context, listen: false);
    appState.getUserData();
    appState.loadInitialData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: AppTheme.PrimaryDarkColor,
          title: Text(_title),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: _profilePhoto != null
                    ? Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(width: 1, color: Colors.white),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(_profilePhoto))),
                      )
                    : Icon(
                        Icons.person_pin,
                        size: 35,
                      ),
                onPressed: () {
                  AppUtils(context).nextPage(
                      page: UserProfileScreen(
                    userToken: appState.userToken,
                  ));
                })
          ],
        ),
        body: EventListScreen(userToken: this.token),
        // IndexedStack(index: _currentIndex, children: [
        //   EventListScreen(userToken: this.token),
        //   RegisterScreen(),
        //   LoginScreen(),
        //   UserProfileScreen(userToken: this.token),
        // ]),
        bottomNavigationBar: BottomNavigationBar(
          // comment this to hide bottom titles
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              AppUtils(context).nextPage(page: TopicsListScreen());
            }
            if (index == 1) {
              AppUtils(context).nextPage(page: HelpScreen());
            }
            if (index == 2) {
              AppUtils(context).nextPage(page: NotificationsScreen());
            }
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

  @override
  bool get wantKeepAlive => true;
}
