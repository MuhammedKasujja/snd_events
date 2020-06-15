import 'package:flutter/material.dart';
import 'package:snd_events/models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({Key key, @required this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
      ),
      body: Container(),
    );
  }
}
