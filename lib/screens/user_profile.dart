import 'package:flutter/material.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/models/child.dart';
import 'package:snd_events/screens/add_child.dart';
import 'package:snd_events/screens/change_password.dart';
import 'package:snd_events/screens/edit_user_profile.dart';
import 'package:snd_events/screens/login.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/add_icon.dart';

class UserProfileScreen extends StatefulWidget {
  final String userToken;

  const UserProfileScreen({Key key, this.userToken}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Child> listChildren;
  @override
  void initState() {
    Repository().getUserProfile(widget.userToken).then((data) {
      print(data);
      //print("children:");
      // print(data['children']);
      setState(() {
        listChildren = (data['children'] as List)
            .map((m) => new Child.fromJson(m))
            .toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.PROFILE),
        actions: <Widget>[
          //IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
          _showPopupMenu(),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                //height: MediaQuery.of(context).size.height / 4,
                // height: 200,
                child: Row(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 12, top: 4),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 65,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Kasujja Muhammed',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        RaisedButton(
                            child: Text('Edit Profile'),
                            onPressed: () {
                              AppUtils(context)
                                  .nextPage(page: EditUserProfileScreen());
                            })
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      "Profession",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                    ),
                    child: AddIcon(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InkWell(
                      child: Chip(
                        label: Text("Add child"),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      onTap: () {
                        AppUtils(context).nextPage(
                            page: AddChilScreen(
                          userToken: widget.userToken,
                        ));
                      },
                    ),
                  ),
                ],
              ),
              listChildren != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listChildren.length,
                      itemBuilder: (context, index) {
                        var child = listChildren[index];
                        return ListTile(title: Text(child.name));
                      })
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _showPopupMenu() => PopupMenuButton(
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Account Settings'),
            ),
            PopupMenuItem(child: Text('Notifications')),
            PopupMenuItem(child: Text('Help')),
            PopupMenuItem(
                child: InkWell(
              child: Text('Change password'),
              onTap: () {
                Navigator.pop(context);
                AppUtils(context).nextPage(
                    page: ChangePasswordScreen(userToken: widget.userToken));
              },
            )),
            PopupMenuItem(
                child: InkWell(
              child: Text('Logout'),
              onTap: () {
                Repository().logout().then((onValue) {
                  // Remove all the previous Routes from the [Route] tree
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false);
                });
              },
            ))
          ]);
}
