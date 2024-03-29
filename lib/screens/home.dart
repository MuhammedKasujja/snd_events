import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/data/botton_nav_items.dart';
import 'package:snd_events/screens/events.dart';
import 'package:snd_events/screens/help.dart';
import 'package:snd_events/screens/notifications.dart';
import 'package:snd_events/screens/topicslist.dart';
import 'package:snd_events/screens/user_profile.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String _profilePhoto;
  String _title = Constants.HOME;
  AppState appState;
  PageController _pageController;
  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    // print('MyToken: ${appState.userToken}');
    _pageController = PageController();
    _pageController.addListener(() {
      var page = _pageController.page.floor();
      _setTitle(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppTheme.PrimaryColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            leading: IconButton(
                icon: _currentIndex == 0
                    ? Container(
                        color: AppTheme.PrimaryColor,
                        child: Center(child: Text('V')),
                      )
                    : Icon(
                        Icons.arrow_back,
                        color: AppTheme.PrimaryColor,
                      ),
                onPressed: () {
                  if (_currentIndex != 0) {
                    _setTitle(0);
                    _pageController.jumpToPage(0);
                  }
                }),
            backgroundColor: Colors.white,
            title: Text(
              _title,
              style: TextStyle(color: AppTheme.PrimaryColor),
            ),
            // elevation: 0.0,
            actions: <Widget>[
              _currentIndex == 0
                  ? IconButton(
                      color: AppTheme.PrimaryColor,
                      icon: _profilePhoto != null
                          ? Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
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
                            // page: BurningTextWidget()
                            page: UserProfileScreen());
                      })
                  : Container(),
              IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppTheme.PrimaryColor,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                    // AppUtils(context).nextPage(
                    //     // page: BurningTextWidget()
                    //     page: UserProfileScreen());
                  }),
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: [
              EventListScreen(),
              TopicsListScreen(),
              HelpScreen(),
              NotificationsScreen()
            ],
          ),
          // IndexedStack(index: _currentIndex, children: [
          //   EventListScreen(userToken: this.token),
          //   RegisterScreen(),
          //   LoginScreen(),
          //   UserProfileScreen(userToken: this.token),
          // ]),
          // drawer: DrawerWidget(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // comment this to hide bottom titles
            unselectedItemColor: Colors.grey[500],
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              _setTitle(index);
              _pageController.jumpToPage(index);
              // if (index == 0) {
              //   // AppUtils(context).nextPage(page: TopicsListScreen());
              // }
              // if (index == 1) {
              //   // AppUtils(context).nextPage(page: HelpScreen());
              // }
              // if (index == 2) {
              //   AppUtils(context).nextPage(page: null);
              // }
              // if (index == 3) {
              //   AppUtils(context).nextPage(page: NotificationsScreen());
              // }
            },
            items: allDestinations.map((destination) {
              return BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  // backgroundColor: destination.color,
                  title: Text(destination.title));
            }).toList(),
          ),
          endDrawer: DrawerWidget(),
        ),
      ),
    );
  }

  _setTitle(index) {
    var title = Constants.APP_NAME;
    if (index == 0) title = Constants.HOME;
    if (index == 1) title = Constants.ARTICLES;
    if (index == 2) title = Constants.ASK;
    if (index == 3) title = Constants.NOTIFICATIONS;
    setState(() {
      _title = title;
      _currentIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
