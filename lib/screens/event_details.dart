import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/comment_textfield.dart';
import 'package:snd_events/screens/view_full_image.dart';

const textPadding = 8.0;

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({Key key, @required this.event}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event Details"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Hero(
                    tag: this.widget.event.photo,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                              // fit: BoxFit.fill,
                              image: NetworkImage(this.widget.event.photo))),
                    ),
                  ),
                  onTap: () {
                    AppUtils(context).nextPage(
                        page: ViewFullImageScreen(
                      imageUrl: this.widget.event.photo,
                    ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Speaker",
                        style: TextStyle(color: AppTheme.PrimaryDarkColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        this.widget.event.speaker ?? "Muhammed Kasujja",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            Icons.event_available,
                            size: 15,
                            color: AppTheme.APP_COLOR,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: textPadding),
                            child: Text(
                                '${this.widget.event.startDate}  *  ${this.widget.event.endDate}'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.newspaper,
                            size: 15,
                            color: AppTheme.APP_COLOR,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: textPadding),
                            child: Text(
                              this.widget.event.theme ??
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
                            child: Text('${this.widget.event.locDistrict}'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            size: 15,
                            color: AppTheme.APP_COLOR,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: textPadding),
                            child: Text(this.widget.event.street),
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
                            child: Text(
                                '''${this.widget.event.startTime.replaceRange(5, 8, '')}  -  ${this.widget.event.endTime.replaceRange(5, 8, '')}'''),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: CommentWidget(onSendClicked: null));
  }
}
