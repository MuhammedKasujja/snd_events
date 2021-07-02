import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/enums/event_type.dart';
import 'package:snd_events/widgets/event_widget.dart';
import 'package:snd_events/widgets/loading.dart';

class EventItemListScreen extends StatefulWidget {
  final EventType eventType;

  const EventItemListScreen({Key key, this.eventType}) : super(key: key);
  @override
  _EventItemListScreenState createState() => _EventItemListScreenState();
}

class _EventItemListScreenState extends State<EventItemListScreen> {
  List<Event> events;

  @override
  Widget build(BuildContext context) {
    var _appState = Provider.of<AppState>(
      context,
    );
    if (widget.eventType == EventType.Suggested) {
      events = _appState.suggestedEvents;
    }
    if (widget.eventType == EventType.Saved) {
      events = _appState.savedEvents;
    }
    if (widget.eventType == EventType.Going) {
      events = _appState.interestedEvents;
    }
    return events == null
        ? FutureBuilder<List<Event>>(
            future: _appState.getMyMeetups(widget.eventType),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return ListView.builder(
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       return Shimmer.fromColors(
                //           child: EventShimmer(),
                //           baseColor: Colors.grey[400],
                //           highlightColor: Colors.white);
                //     });
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LoadingWidget(),
                ));
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Container(
                          height: 30, width: 50, child: Text("Try again")),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              }
              return showData(snapshot.data);
            },
          )
        : showData(events);
  }

  Widget noDataFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Please save some events',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget showData(List<Event> snapshot) {
    if (snapshot.length <= 0) return noDataFound();
    return ListView.builder(
      itemCount: snapshot.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return EventWidget(
          event: snapshot[index],
        );
      },
    );
  }
}
