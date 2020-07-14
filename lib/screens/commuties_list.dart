import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/screens/add_community.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/community_item.dart';

class CommunityListWidget extends StatefulWidget {
  final String userToken;

  const CommunityListWidget({Key key, @required this.userToken})
      : super(key: key);
  @override
  _CommunityListState createState() => _CommunityListState();
}

class _CommunityListState extends State<CommunityListWidget> {
  Future<List<Community>> listCommunities;
  @override
  void initState() {
    listCommunities = Provider.of<AppState>(context, listen: false)
        .getMyGroups()
        .catchError((onError) {
      print("CommunitiesError: $onError");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[300],
      height: 150,
      child: FutureBuilder<List<Community>>(
          future: listCommunities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: AppTheme.PrimaryDarkColor,
                  ),
                ),
              );
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
                        // snapshot.connectionState = ConnectionState.waiting;
                        listCommunities = getGroups();
                      });
                    },
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == snapshot.data.length) {
                  return Container(
                    child: Center(
                        child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        AppUtils(context).nextPage(
                            page: AddCommunityScreen(
                                userToken: widget.userToken));
                      },
                    )),
                  );
                }
                return CommunityItemWidget(
                  community: snapshot.data[index],
                );
              },
            );
          }),
    );
  }

  Future<List<Community>> getGroups() async {
    var data =  await Provider.of<AppState>(context, listen: false)
        .getMyGroups()
        .catchError((onError) {
      print("CommunitiesError: $onError");
    });
    return data;
  }
}
