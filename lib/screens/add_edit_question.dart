import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/models/question.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.with.controller.dart';

class AddEditQuestionScreen extends StatefulWidget {
  final Function(Question child) onQuestionAdded;
  final Question question;

  const AddEditQuestionScreen(
      {Key key, this.onQuestionAdded, this.question})
      : super(key: key);
  @override
  _AddEditQuestionScreenState createState() => _AddEditQuestionScreenState();
}

class _AddEditQuestionScreenState extends State<AddEditQuestionScreen> {
  List<ChildCondition> childConditions;
  List<int> selectedConditions = [];
  AppState appState;
  bool isSubmitting = false;
  
  final TextEditingController _controller = TextEditingController();
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
    if(widget.question != null){
      //  appState
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask a question"),
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
                TextfieldControllerWidget(
                    controller: _controller, hint: 'Type something'),
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
                    ? _checklistConditions()
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
                    appState
                        .askQuestion(
                      _controller.text,
                      selectedConditions,
                    )
                        .then((data) {
                          appState.fetchQuestions();
                      _showPageSubmitting(false);
                      AppUtils.showToast("${data['response']}");
                      print("Response: $data");
                    }).catchError((onError) {
                      _showPageSubmitting(false);
                      AppUtils.showToast('Somethng went wrong');
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
    return _controller.text.isNotEmpty;
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
