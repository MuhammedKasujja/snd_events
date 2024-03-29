import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/models/child.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/dateformatted_textfield.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';
import 'package:snd_events/widgets/select_child_conditions.dart';

class AddChilScreen extends StatefulWidget {
  final String userToken;
  final Function(Child child) onChildAdded;

  const AddChilScreen({Key key, @required this.userToken, this.onChildAdded})
      : super(key: key);
  @override
  _AddChilScreenState createState() => _AddChilScreenState();
}

class _AddChilScreenState extends State<AddChilScreen> {
  String gender, firstname, lastname, dob;
  List<ChildCondition> childConditions;
  List selectedConditions = [];
  // final _multiSelectKey = GlobalKey<MultiSelectDropdownState>();
  AppState appState;
  bool isSubmitting = false;
  @override
  void initState() {
    appState = Provider.of<AppState>(context, listen: false);
    if (appState.childConditions != null) {
      childConditions = appState.childConditions;
    } else {
      appState.getChildConditionsList().then((data) {
        // print("Conditions: $data");
        if (mounted)
          setState(() {
            childConditions = data;
          });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Child"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(3),
          child: Container(
            width: double.infinity,
            child: isSubmitting ? LinearProgressIndicator() : Container(),
            color: Colors.black,
          ),
        ),
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
                Text(
                  'Tell us about your child',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                TextfieldWidget(
                    inputType: TextInputType.text,
                    onTextChange: (value) {
                      setState(() {
                        firstname = value;
                      });
                    },
                    hint: 'Firstname'),
                TextfieldWidget(
                    inputType: TextInputType.text,
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
                        color: AppTheme.PrimaryDarkColor,
                        fontSize: 13.5,
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
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Date of Birth",
                //     style: TextStyle(
                //       color: AppTheme.PrimaryDarkColor,
                //       fontSize: 13.5,
                //     ),
                //   ),
                // ),
                DateInputTextField(
                  onTextChange: (date) {
                    setState(() {
                      dob = date;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Condition(s)",
                      style: TextStyle(
                        color: AppTheme.PrimaryDarkColor,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                childConditions != null
                    ? ChildConditionWidget(
                        onselectedConditions: (conditions) {
                          print(conditions);
                          // setState(() {
                          selectedConditions = conditions;
                          // });
                        },
                      )
                    //_checklistConditions()

                    // ? FlutterMultiChipSelect(
                    //         key: _multiSelectKey,
                    //         label: 'Select Conditions',
                    //         elements: List.generate(
                    //             childConditions.length,
                    //             (index) => MultiSelectItem<String>.simple(
                    //                 title: childConditions[index].name,
                    //                 value:
                    //                     childConditions[index].id.toString())),
                    //         values: [])
                    : Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.PrimaryDarkColor,
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                SubmitButtonWidget(onPressed: () {
                  if (_validateFields()) {
                    _showPageSubmitting(true);
                    Repository()
                        .addChild(
                      token: widget.userToken,
                      firstname: firstname,
                      lastname: lastname,
                      dob: dob,
                      gender: gender,
                      // conditions: this._multiSelectKey.currentState.result,
                      conditions: selectedConditions,
                    )
                        .then((data) {
                      _showPageSubmitting(false);
                      AppUtils.showToast("${data['response']}");
                      this.widget.onChildAdded(Child(
                          name: "$firstname $lastname",
                          age: 0,
                          gender: gender));
                      print("Response: $data");
                    }).catchError((onError) {
                      _showPageSubmitting(false);
                      AppUtils.showToast('Somethng went wrong');
                      print('CatchError $onError');
                    });
                  } else {
                    AppUtils.showToast(Constants.HINT_FILL_ALL_FIELDS);
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
        dob.isNotEmpty;
  }

  Widget _checklistConditions() {
    return ListView.builder(
        itemCount: childConditions.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CheckboxListTile(
              activeColor: AppTheme.PrimaryDarkColor,
              title: Text(childConditions[index].name),
              value: selectedConditions.contains(childConditions[index].id),
              onChanged: (val) {
                setState(() {
                  if (selectedConditions.contains(childConditions[index].id)) {
                    selectedConditions.remove(childConditions[index].id);
                  } else {
                    selectedConditions.add(childConditions[index].id);
                  }
                });
                // print(selectedConditions);
              });
        });
  }

  _showPageSubmitting(bool showLoading) {
    setState(() {
      isSubmitting = showLoading;
    });
  }
}
