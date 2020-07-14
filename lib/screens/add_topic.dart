import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/description_textfield.dart';
import 'package:snd_events/widgets/loading.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';
import 'package:snd_events/models/topic.dart';

class AddTopicScreen extends StatefulWidget {
  final String userToken;

  const AddTopicScreen({Key key, this.userToken}) : super(key: key);
  @override
  _AddTopicScreenState createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  List<ChildCondition> childConditions;
  String title, _desc;
  List<int> selectedConditions = [];
  AppState appState;
  @override
  void initState() {
     appState = Provider.of<AppState>(context, listen: false);
    Repository().getChildConditions(token: appState.userToken).then((data) {
      // print("Conditions: $data");
      if (mounted)
        setState(() {
          childConditions = data;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Topic"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextfieldWidget(
                  onTextChange: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  hint: 'Title'),
              DescriptionTextfieldWidget(
                onTextChange: (val) {
                  setState(() {
                    _desc = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              childConditions != null
                  ? _checklistConditions()
                  : LoadingWidget(),
              SizedBox(
                height: 10,
              ),
              SubmitButtonWidget(onPressed: () {
                Repository()
                    .addTopic(
                        token: appState.userToken,
                        title: title,
                        desc: _desc,
                        conditions: selectedConditions)
                    .then((data) {
                      AppUtils.showToast(data[Constants.KEY_RESPONSE]);
                      var topic = Topic(title: title, time: DateTime.now().toString(), details: _desc);
                      appState.addTopic(topic);
                  print(data);
                });
              }),
            ],
          ),
        ),
      ),
    );
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
              value: selectedConditions
                  .contains(childConditions[index].id),
              onChanged: (val) {
                setState(() {
                  if (selectedConditions
                      .contains(childConditions[index].id)) {
                    selectedConditions
                        .remove(childConditions[index].id);
                  } else {
                    selectedConditions.add(childConditions[index].id);
                  }
                });
                // print(selectedConditions);
              });
        });
  }
}
