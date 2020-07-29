import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snd_events/models/topic.dart';
import 'package:snd_events/screens/add_topic.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/event_loading.dart';

class TopicsListScreen extends StatefulWidget {
  @override
  _TopicsListScreenState createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {
  Future<List<Topic>> futureTopics;

  AppState appState;
  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    futureTopics = appState.getTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              AppUtils(context).nextPage(page: AddTopicScreen());
            },
          )
        ],
      ),
      body:
          // Container(
          //   child: appState.topics == null ?
          //   // LoadingWidget()
          //   ListView.builder(
          //         itemCount: 10,
          //         itemBuilder: (context, index) {
          //           return Shimmer.fromColors(
          //               child: EventLoadingWidget(size: 60,),
          //               baseColor: Colors.grey[400],
          //               highlightColor: Colors.white);
          //         })
          //    : _buildTopicList(appState.topics),
          // )
          Container(
              child: FutureBuilder<List<Topic>>(
        future: futureTopics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                      child: EventLoadingWidget(
                        size: 60,
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white);
                });
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
                    setState(() {
                      futureTopics =
                          Provider.of<AppState>(context, listen: false)
                              .getTopics();
                    });
                  },
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                      height: 30, width: 50, child: Text("No data found")),
                ),
              ),
            );
          }
          return _buildTopicList(snapshot.data);
        },
      )),
    );
  }

  Widget _buildTopicList(List<Topic> topics) => ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          var topic = topics[index];
          var parts = topic.time.split("T");

          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(topic.title),
            subtitle: Row(
              children: <Widget>[
                // Icon(
                //   Icons.access_time,
                //   color: Colors.grey[400],
                //   size: 15,
                // ),
                Text('Published'),
                SizedBox(
                  width: 5,
                ),
                Text(
                  parts[0],
                  // topic.time.replaceRange(19, topic.time.length, ''),
                  // topics[index].details,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(parts[1].replaceRange(5, parts[1].length, ''))
              ],
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.PrimaryDarkColor,
                ),
                onPressed: null),
            onTap: () {},
          );
        },
      );
}
