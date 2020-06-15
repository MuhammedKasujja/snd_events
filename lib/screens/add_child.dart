import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';

class AddChilScreen extends StatefulWidget {
  final String userToken;

  const AddChilScreen({Key key, @required this.userToken}) : super(key: key);
  @override
  _AddChilScreenState createState() => _AddChilScreenState();
}

class _AddChilScreenState extends State<AddChilScreen> {
  String gender, firstname, lastname, dob, condition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Child"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text('Tell us about your child'),
                SizedBox(
                  height: 10,
                ),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        firstname = value;
                      });
                    },
                    hint: 'Firstname'),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        lastname = value;
                      });
                    },
                    hint: 'Lastname'),
                Row(
                  children: <Widget>[
                    Text(
                      "Gender",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    FlatButton.icon(
                      splashColor: Colors.transparent,
                      label: Text('Male'),
                      icon: Radio(
                        value: 'M',
                        groupValue: gender,
                        onChanged: _changeGender,
                      ),
                      onPressed: () {
                        _changeGender('M');
                      },
                    ),
                    FlatButton.icon(
                      splashColor: Colors.transparent,
                      label: Text("Female"),
                      icon: Radio(
                        value: 'F',
                        groupValue: gender,
                        onChanged: _changeGender,
                      ),
                      onPressed: () {
                        _changeGender('F');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //
                //Date of birth
                //
                // Row(
                //   children: <Widget>[
                //     Text(
                //       "Date of Birth",
                //       style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 12,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // CalendarDatepickerWidget(
                //   onDateChanged: (date) {
                //     setState(() {
                //       dob = date;
                //     });
                //   },
                // ),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        dob = value;
                      });
                    },
                    hint: 'Date of Birth'),
                SizedBox(
                  height: 10,
                ),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        condition = value;
                      });
                    },
                    hint: 'Condition'),
                SubmitButtonWidget(onPressed: () {
                  if (_validateFields()) {
                    Repository()
                        .addChild(
                            token: widget.userToken,
                            firstname: firstname,
                            lastname: lastname,
                            dob: dob,
                            gender: gender,
                            condition: condition)
                        .then((data) {
                      AppUtils.showToast("${data['response']}");
                      print("Response: $data");
                    });
                  } else {
                    AppUtils.showToast("Please fill all fields");
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changeGender(value) {
    setState(() {
      gender = value;
    });
  }

  bool _validateFields() {
    return firstname != null &&
        firstname.isNotEmpty &&
        lastname != null &&
        lastname.isNotEmpty &&
        gender != null &&
        gender.isNotEmpty &&
        dob != null &&
        dob.isNotEmpty &&
        condition != null &&
        condition.isNotEmpty;
  }
}
