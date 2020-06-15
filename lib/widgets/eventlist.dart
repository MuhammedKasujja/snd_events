import 'package:flutter/material.dart';
import 'package:snd_events/widgets/event_item.dart';

class EventItemListScreen extends StatefulWidget {
  @override
  _EventItemListScreenState createState() => _EventItemListScreenState();
}

class _EventItemListScreenState extends State<EventItemListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return EventItemWidget();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
