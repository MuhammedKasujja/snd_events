import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/notification.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/widgets/loading.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Notifications"),
      // ),
      body: FutureBuilder<List<NotificationModel>>(
        future: Provider.of<AppState>(context).fetchNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }
          if (snapshot.hasError) {
            return Text('Try Again');
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                // var bgColor = (index%2 ==0 ) ? Colors.blue[50] : Colors.white; 
                var notification = snapshot.data[index];
                return Container(
                  // color: bgColor,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CircleAvatar(
                          child: Text(
                              notification.sourceType == 'event' ? 'E' : 'G'),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 4, left: 20),
                            child: RichText(
                              text: TextSpan(
                                text: '${notification.sender} Shared in ',
                                children: [
                                  TextSpan(
                                      text: '${notification.source} . ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // go to source page
                                          print('This sounds great');
                                        }),
                                  TextSpan(
                                    text: '${notification.time}h ago',
                                  )
                                ],
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 40),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 0.1, color: Colors.black54)),
                              child: Text(
                                '${notification.message}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
