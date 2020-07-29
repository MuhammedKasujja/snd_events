import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/widgets/event_item.dart';
import 'package:snd_events/enums/event_type.dart';
import 'package:snd_events/widgets/loading.dart';

class EventItemListScreen extends StatefulWidget {
  final EventType eventType;

  const EventItemListScreen({Key key, this.eventType})
      : super(key: key);
  @override
  _EventItemListScreenState createState() => _EventItemListScreenState();
}

class _EventItemListScreenState extends State<EventItemListScreen> {
  List<Event> events;

  @override
  Widget build(BuildContext context) {
    var _appState = Provider.of<AppState>(context,);
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
        ? Center(
            child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LoadingWidget(),
          ))
        : ListView.builder(
            itemCount: events.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return EventItemWidget(
                event: events[index],
              );
            });

    // return FutureBuilder<List<Event>>(
    //   future: events,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: Padding(
    //         padding: const EdgeInsets.all(20.0),
    //         child: LoadingWidget(),
    //       ));
    //       // return ListView.builder(
    //       //     itemCount: 4,
    //       //     itemBuilder: (context, index) {
    //       //       return Shimmer.fromColors(
    //       //           child: EventLoadingWidget(),
    //       //           baseColor: Colors.grey[400],
    //       //           highlightColor: Colors.white);
    //       //     });
    //     }
    //     if (snapshot.hasError) {
    //       return Padding(
    //         padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: InkWell(
    //             child:
    //                 Container(height: 30, width: 50, child: Text("Try again")),
    //             onTap: () {
    //               setState(() {
    //                 events = Repository().getMyMeetups(widget.eventType,
    //                     token: widget.userToken);
    //               });
    //             },
    //           ),
    //         ),
    //       );
    //     }
    //     return ListView.builder(
    //       itemCount: snapshot.data.length,
    //       physics: NeverScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       itemBuilder: (context, index) {
    //         return EventItemWidget(
    //           event: snapshot.data[index],
    //         );
    //       },
    //     );
    //   },
    // );
  }

}
