import 'package:flutter/material.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/circular_image.dart';
import 'package:snd_events/widgets/textfield.dart';

class EditUserProfileScreen extends StatefulWidget {
  final String userToken;

  const EditUserProfileScreen({Key key, this.userToken}) : super(key: key);

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  String fname, lname, email; var imagePath;
  @override
  void initState() {
    Repository().getUserProfile(widget.userToken).then((data) {
      print(data);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.EDIT_PROFILE),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Repository().updateProfile(
                    token: widget.userToken,
                    email: email,
                    name: '$fname $lname',
                    file: imagePath).then((data) {
                       AppUtils.showToast(data[Constants.KEY_RESPONSE]);
                    });
              })
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.8,
                  // height: 200,
                  child: Center(child: CircularImageWidget(
                    onImageChanged: (image) {
                      setState(() {
                        imagePath = image;
                      });
                      print(image);
                    },
                  )),
                ),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        fname = value;
                      });
                    },
                    hint: Constants.HINT_FIRSTNAME),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        lname = value;
                      });
                    },
                    hint: Constants.HINT_LASTNAME),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    hint: Constants.HINT_EMAIL),
                //Spacer(),
                SizedBox(height: 20),
                InkWell(
                  child: Text(
                    "I would love to help",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        //fontSize: 18,
                        color: Colors.grey),
                  ),
                  onTap: () {
                    print("object");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
