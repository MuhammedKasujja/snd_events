import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/screens/event_details.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';

const textPadding = 6.0;

class EventItemWidget extends StatelessWidget {
  final Event event;

  const EventItemWidget({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                //                   <--- left side
                color: AppTheme.PrimaryDarkColor,
                width: 3.0,
              ),
            )),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(this.event.photo),
                            fit: BoxFit.fill)),
                  ),
                ),
                Column(
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
                          child: Text(this.event.startDate ?? 'Wed, Nov 28'),
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
                            this.event.theme ?? "How to make your child fit in",
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
                          child: Text(this.event.locDistrict ??
                              "Special parents Mukono"),
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
                              this.event.street ?? "4 PM, Abba House, Lumuli."),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        AppUtils(context).nextPage(page: EventDetailsScreen(event: this.event));
      },
    );
  }
}
