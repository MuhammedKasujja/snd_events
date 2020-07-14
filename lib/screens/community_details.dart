import 'package:flutter/material.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/screens/view_full_image.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/comment_textfield.dart';

class CommunityDetailsScreen extends StatelessWidget {
  final Community community;

  const CommunityDetailsScreen({Key key, @required this.community})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Group Details"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  child: Hero(
                    tag: this.community.image,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(this.community.image))),
                    ),
                  ),
                  onTap: () {
                    AppUtils(context).nextPage(
                        page: ViewFullImageScreen(
                            imageUrl: this.community.image));
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.community.name ?? "Group Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${this.community.country},'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(this.community.locDistrict ?? "Group District"),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          this.community.description ?? "Group description"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: CommentWidget(onSendClicked: null));
  }
}
