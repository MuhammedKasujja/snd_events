import 'package:flutter/material.dart';
import 'package:snd_events/screens/add_edit_community.dart';
import 'package:snd_events/screens/add_edit_event.dart';
import 'package:snd_events/screens/commuties_list.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/add_icon.dart';
import 'package:snd_events/widgets/event_type_icon.dart';
import 'package:snd_events/widgets/eventlist.dart';
import 'package:snd_events/enums/event_type.dart';
import 'package:snd_events/utils/constants.dart';

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
        SizedBox(
          height: 6,
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
                page: AddEditEventScreen(
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
                color: currentEventIndex == 0 ? selectedColor : Colors.white,
                type: Constants.EVENT_TYPE_SUGGESTED,
                onSelected: () {
                  setState(() {
                    currentEventIndex = 0;
                  });
                }),
            EventTypeIcon(
                textColor:
                    currentEventIndex == 1 ? Colors.white : selectedColor,
                color: currentEventIndex == 1 ? selectedColor : Colors.white,
                type: Constants.EVENT_TYPE_SAVED,
                onSelected: () {
                  setState(() {
                    currentEventIndex = 1;
                  });
                }),
            EventTypeIcon(
              textColor: currentEventIndex == 2 ? Colors.white : selectedColor,
              color: currentEventIndex == 2 ? selectedColor : Colors.white,
              type: Constants.EVENT_TYPE_GOING,
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
              eventType: EventType.Suggested,
            ),
            EventItemListScreen(
              key: Key("items2"),
              eventType: EventType.Saved,
            ),
            EventItemListScreen(
              key: Key("items3"),
              eventType: EventType.Going,
            ),
          ],
        )
      ],
    );
  }
}
