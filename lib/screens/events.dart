import 'package:flutter/material.dart';
import 'package:snd_events/screens/add_community.dart';
import 'package:snd_events/screens/add_event.dart';
import 'package:snd_events/screens/commuties_list.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/add_icon.dart';
import 'package:snd_events/widgets/event_type_icon.dart';
import 'package:snd_events/widgets/eventlist.dart';
import 'package:snd_events/enums/event_type.dart';

class EventListScreen extends StatefulWidget {
  final String userToken;

  const EventListScreen({Key key, @required this.userToken}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  var currentEventIndex = 0;
  var selectedColor = AppTheme.PrimaryDarkColor;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       'Communities',
        //       style: TextStyle(color: Colors.grey),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 2,
        ),
        CommunityListWidget(userToken: this.widget.userToken),
        Center(
          child: InkWell(
            child: Text(
              "+ New Group",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            onTap: () {
              AppUtils(context).nextPage(
                  page: AddCommunityScreen(userToken: widget.userToken));
            },
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 16,
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Events",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
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
                color: currentEventIndex == 0? selectedColor : Colors.white,
                type: 'Suggested',
                onSelected: () {
                  setState(() {
                    currentEventIndex = 0;
                  });
                }),
            EventTypeIcon(
                textColor:
                    currentEventIndex == 1 ? Colors.white : selectedColor,
                color: currentEventIndex == 1 ? selectedColor : Colors.white,
                type: 'Saved',
                onSelected: () {
                  setState(() {
                    currentEventIndex = 1;
                  });
                }),
            EventTypeIcon(
              textColor:
                  currentEventIndex == 2? Colors.white : selectedColor,
              color: currentEventIndex == 2 ? selectedColor : Colors.white,
              type: 'Going',
              onSelected: () {
                setState(() {
                  currentEventIndex = 2;
                });
              },
            ),
          ],
        ),
        IndexedStack(
          index: currentEventIndex,
          children: <Widget>[
            EventItemListScreen(
              key: Key("items1"),
              userToken: widget.userToken,
              eventType: EventType.Suggested,
            ),
            EventItemListScreen(
              key: Key("items2"),
              userToken: widget.userToken,
              eventType: EventType.Saved,
            ),
            EventItemListScreen(
              key: Key("items3"),
              userToken: widget.userToken,
              eventType: EventType.Going,
            ),
          ],
        )
      ],
    );
  }
}
