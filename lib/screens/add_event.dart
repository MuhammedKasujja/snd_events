import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';

class AddEventScreen extends StatefulWidget {
  final String userToken;

  const AddEventScreen({Key key, @required this.userToken}) : super(key: key);
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String theme, startDate, endDate, speaker, district, building;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        theme = value;
                      });
                    },
                    hint: 'Theme'),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: TextfieldWidget(
                          onTextChange: (value) {
                            setState(() {
                              startDate = value;
                            });
                          },
                          hint: 'Start Date'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextfieldWidget(
                          onTextChange: (value) {
                            setState(() {
                              endDate = value;
                            });
                          },
                          hint: 'End Date'),
                    ),
                  ],
                ),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        speaker = value;
                      });
                    },
                    hint: 'Speaker'),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        district = value;
                      });
                    },
                    hint: 'District'),
                TextfieldWidget(
                    onTextChange: (value) {
                      setState(() {
                        building = value;
                      });
                    },
                    hint: 'Building Street'),
                SubmitButtonWidget(onPressed: () {
                  if (_validateFields()) {
                    Repository()
                        .addEvent(
                            token: widget.userToken,
                            speaker: speaker,
                            endDate: endDate,
                            startDate: startDate,
                            locationDistrict: district,
                            buildingStreet: building,
                            theme: theme)
                        .then((data) {
                      AppUtils.showToast("${data['response']}");
                      print("Response: $data");
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

  bool _validateFields() {
    return theme != null &&
        theme.isNotEmpty &&
        startDate != null &&
        startDate.isNotEmpty &&
        endDate != null &&
        endDate.isNotEmpty &&
        speaker != null &&
        speaker.isNotEmpty &&
        district != null &&
        district.isNotEmpty &&
        building != null &&
        building.isNotEmpty;
  }
}
