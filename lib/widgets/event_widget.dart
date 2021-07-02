import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/screens/event_details.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';

const textPadding = 6.0;

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Card(
            elevation: 5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    this.event.photo))),
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                blurRadius: 18,
                              )
                            ]),
                            width: 50,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '${this.event.startDate.split('-')[2]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ))),
                                // Divider(),
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme.PrimaryColor,//Colors.green[100],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    width: double.infinity,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                          '${AppUtils.eventMonth(this.event.startDate)}',
                                          //'${this.event.startDate.split('-')[2]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    )))
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return RadialGradient(
                                  tileMode: TileMode.mirror,
                                  radius: 1.0,
                                  center: Alignment.topLeft,
                                  colors: <Color>[
                                    Colors.yellow,
                                    Colors.deepOrange.shade900
                                  ]).createShader(bounds);
                            },
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //       'This event is exceptional to u and me as well I love it how about u lady',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold)),
                            // ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Text('${event.theme}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            '${event.street}, ${event.locDistrict}',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Row(
                          children: <Widget>[
                            Chip(
                              //elevation: 1,
                              padding: EdgeInsets.all(2),
                              label: Text(
                                  '${this.event.startTime.replaceRange(5, 8, '')}',
                                  style: TextStyle(
                                      color: Colors.white,//AppTheme.PrimaryColor,
                                      fontWeight: FontWeight.bold)),
                              backgroundColor: AppTheme.PrimaryColor,//Colors.green[100],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Chip(
                             // elevation: 1,
                              padding: EdgeInsets.all(2),
                              label: Text(
                                '${this.event.endTime.replaceRange(5, 8, '')}',
                                style: TextStyle(
                                  color: Colors.white,
                                    // color: AppTheme.PrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: AppTheme.PrimaryColor,//Colors.green[100],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          AppUtils(context).nextPage(page: EventDetailsScreen(event: this.event));
        },
      ),
    );
  }
}
