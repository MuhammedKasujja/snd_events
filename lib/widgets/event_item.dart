import 'package:flutter/material.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/screens/event_details.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';

class EventItemWidget extends StatefulWidget {
  final Event event;

  const EventItemWidget({Key key, this.event}) : super(key: key);

  @override
  _EventItemWidgetState createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  static const textPadding = 6.0;
  @override
  void initState() {
    super.initState();
    var date = DateTime.now();
    //date.
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 15,
                      color: AppTheme.APP_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: textPadding),
                      child: Text('Wed, Nov 28'),
                    ),
                  ],
                ),
                
                SizedBox(
                  height: 10,
                ),
                 Row(
                  children: <Widget>[
                    Icon(
                      Icons.event_note,
                      size: 15,
                      color: AppTheme.APP_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: textPadding),
                      child: Text(
                        "How to make your child fit in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: AppTheme.APP_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: textPadding),
                      child: Text("Special parents Mukono"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
               
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 15,
                      color: AppTheme.APP_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: textPadding),
                      child: Text("4 PM, Abba House, Lumuli."),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        AppUtils(context)
            .nextPage(page: EventDetailsScreen(event: this.widget.event));
      },
    );
  }

  String _formattedDate(String startDate) {
    var date = DateTime.parse(startDate);
    // if()
  }
}
