import 'package:flutter/material.dart';
import 'package:snd_events/screens/add_event.dart';
import 'package:snd_events/screens/user_profile.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/add_icon.dart';
import 'package:snd_events/widgets/event_type_icon.dart';
import 'package:snd_events/widgets/eventlist.dart';

class EventListScreen extends StatefulWidget {
  final String userToken;

  const EventListScreen({Key key, @required this.userToken}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  var currentEventIndex = 0;
  var selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constants.APP_NAME),
            //elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.person_pin,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    AppUtils(context).nextPage(
                        page: UserProfileScreen(
                      userToken: this.widget.userToken,
                    ));
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Container(
                //   color: Colors.blue,
                //   width: double.infinity,
                //   height: 60,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 15, left: 10),
                //     child: Text(
                //       Constants.APP_NAME,
                //       style: TextStyle(
                //           //fontWeight: FontWeight.bold,
                //           fontSize: 22,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Communities',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return eventItem(index);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    "+ New Group",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 16,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AddIcon(
                        page: AddEventScreen(
                          userToken: this.widget.userToken,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    EventTypeIcon(
                      textColor:
                          currentEventIndex == 0 ? Colors.white : selectedColor,
                      color:
                          currentEventIndex == 0 ? selectedColor : Colors.white,
                      type: 'Going',
                      onSelected: () {
                        setState(() {
                          currentEventIndex = 0;
                        });
                      },
                    ),
                    EventTypeIcon(
                        textColor: currentEventIndex == 1
                            ? Colors.white
                            : selectedColor,
                        color: currentEventIndex == 1
                            ? selectedColor
                            : Colors.white,
                        type: 'Saved',
                        onSelected: () {
                          setState(() {
                            currentEventIndex = 1;
                          });
                        }),
                    EventTypeIcon(
                        textColor: currentEventIndex == 2
                            ? Colors.white
                            : selectedColor,
                        color: currentEventIndex == 2
                            ? selectedColor
                            : Colors.white,
                        type: 'Suggested',
                        onSelected: () {
                          setState(() {
                            currentEventIndex = 2;
                          });
                        }),
                  ],
                ),
                //Expanded(child: Container()),
                EventItemListScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eventItem(index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20.0))
            //shape:
            ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
