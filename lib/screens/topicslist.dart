import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snd_events/models/topic.dart';
import 'package:snd_events/screens/add_topic.dart';
import 'package:snd_events/states/app_state.dart';
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
    futureTopics = Provider.of<AppState>(context, listen: false).getTopics();
    // appState = Provider.of<AppState>(context, listen: false);
    // appState.getTopics();
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
          return _buildTopicList(snapshot.data);
        },
      )),
    );
  }

  Widget _buildTopicList(List<Topic> topics) => ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index].title),
            trailing: Text(topics[index]
                .time
                .replaceRange(19, topics[index].time.length, '')),
            onTap: () {},
          );
        },
      );
}
