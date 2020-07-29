import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/screens/view_full_image.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/screens/add_edit_community.dart';

class CommunityDetailsScreen extends StatefulWidget {
  final Community community;

  const CommunityDetailsScreen({Key key, @required this.community})
      : super(key: key);

  @override
  _CommunityDetailsScreenState createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  bool hasJoined = false;
  bool isLoading = false;
  AppState _appState;
  File updatedImage;
  @override
  void initState() {
    _appState = Provider.of<AppState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Details"),
        // actions: <Widget>[
        //   widget.community.createdBy == _appState.user.email
        //       ? IconButton(
        //           icon: Icon(Icons.edit),
        //           onPressed: () {
        //             AppUtils(context).nextPage(
        //                 page: AddCommunityScreen(
        //               community: widget.community,
        //             ));
        //           },
        //         )
        //       : InkWell(
        //           child: Padding(
        //             padding: const EdgeInsets.only(top: 12, right: 10),
        //             child: Container(
        //                 child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text(hasJoined ? 'Leave' : 'Join'),
        //             )),
        //           ),
        //           onTap: _joinLeaveGroup,
        //         )
        // ],
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Hero(
                  tag: this.widget.community.image,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: updatedImage == null
                                ? CachedNetworkImageProvider(
                                    this.widget.community.image)
                                : FileImage(updatedImage))),
                  ),
                ),
              ],
            ),
            onTap: () {
              AppUtils(context).nextPage(
                  page: ViewFullImageScreen(
                      imageUrl: this.widget.community.image));
            },
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(30),
                    //     topRight: Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${this.widget.community.name}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${this.widget.community.country},'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(this.widget.community.locDistrict ?? "City"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description', style: TextStyle(fontSize: 16)),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${this.widget.community.description}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Topics'),
                ),
                groupTopics(),
                _appState.user.email != widget.community.createdBy
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Created By",
                              ),
                            ),
                            Text(widget.community.createdBy,
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _appState.user.email == widget.community.createdBy
          ? FloatingActionButton(
              onPressed: () {
                AppUtils(context).nextPage(
                    page: AddCommunityScreen(
                        community: widget.community,
                        updateCommunity: _updatedCommunity));
              },
              tooltip: 'Edit Community',
              child: Icon(Icons.edit),
              backgroundColor: AppTheme.PrimaryColor)
          : FloatingActionButton.extended(
              onPressed: _joinLeaveGroup,
              label: Text(hasJoined ? 'Leave' : 'Join'),
              tooltip: 'Join Community',
              icon: Icon(hasJoined ? Icons.clear : Icons.add),
              backgroundColor: AppTheme.PrimaryColor,
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  _joinLeaveGroup() {
    setState(() {
      isLoading = true;
    });
    Provider.of<AppState>(context, listen: false)
        .joinOrLeaveGroup(
      widget.community.id,
    )
        .then((value) {
      print(value);
      setState(() {
        hasJoined = !hasJoined;
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget groupTopics() {
    List<Widget> topics = [];
    for (int i in List<int>.from(widget.community.topics)) {
      for (var condition in _appState.childConditions) {
        if (condition.id == i) {
          topics.add(Padding(
            padding: const EdgeInsets.all(2.0),
            child: Chip(
              label: Text(
                condition.name,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppTheme.PrimaryDarkColor,
            ),
          ));
        }
      }
    }
    return Wrap(
      children: topics,
    );
  }

  _updatedCommunity(Community community) {
    setState(() {
      widget.community.description = community.description;
      widget.community.name = community.name;
      widget.community.locDistrict = community.locDistrict;
      widget.community.country = community.country;
      widget.community.topics = community.topics;
      // widget.community.image = community.image;
      updatedImage = File(community.image);
    });
  }
}
