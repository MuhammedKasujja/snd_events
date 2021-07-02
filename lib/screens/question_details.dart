import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/models/question.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/widgets/textfield.with.controller.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/widgets/comment_textfield.dart';
import 'package:snd_events/models/answer.dart';
import 'package:snd_events/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final Question question;
  final Function(Question question) onReply;

  const QuestionDetailsScreen({Key key, @required this.question, this.onReply})
      : super(key: key);
  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final _controller = TextEditingController();
  AppState _appState;
  List<Answer> listAnswers;
  int totalAnswers;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    totalAnswers = widget.question.totalAnswers;
    _appState = Provider.of<AppState>(context, listen: false);
    _appState.fetchQuestionAnswers(widget.question.id).then((data) {
      setState(() {
        listAnswers = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(3),
          child: Container(
            width: double.infinity,
            child: isSubmitting ? LinearProgressIndicator() : Container(),
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '${widget.question.question} ?',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: <Widget>[
                  Text('Replies'),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('$totalAnswers'),
                  ),
                ],
              ),
            ),
            Divider(),
            listAnswers == null
                ? Container(
                    child: LoadingWidget(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: listAnswers.length,
                    // physics: NeverScrollingPhysics(),
                    itemBuilder: (context, index) {
                      var answer = listAnswers[index];
                      return ListTile(
                        key: Key('${answer.id}'),
                        subtitle: Text('${answer.answeredBy}'),
                        title: Text('${answer.text}'),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    answer.userPhoto),
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //     AppTheme.PrimaryAssentColor, BlendMode.colorBurn)
                              )),
                        ),
                        trailing: InkWell(
                          child: Container(
                            // width: 60,
                            child: Column(
                              children: [
                                Container(
                                    decoration:
                                        BoxDecoration(color: Colors.green[100]),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 6.0),
                                      child: Text('${answer.approvals}'),
                                    )),
                                SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: 'Approve',
                                      // recognizer: new TapGestureRecognizer()
                                      //   ..onTap = () {},
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          letterSpacing: 1.5,
                                          color: Colors.blue)),
                                )
                              ],
                            ),
                            // Switch(
                            //   onChanged: (bool value) {
                            //     setState(() {
                            //       if (listAnswers[index].approvals == 0) {
                            //         listAnswers[index].approvals = 1;
                            //       } else {
                            //         listAnswers[index].approvals = 0;
                            //       }
                            //     });
                            //     _appState
                            //         .approveAnswer(listAnswers[index].id)
                            //         .then((value) {
                            //       print(value);
                            //     });
                            //   },
                            //   value: listAnswers[index].approvals == 0
                            //       ? true
                            //       : false,
                            // )
                          ),
                          onTap: () {
                            _appState.approveAnswer(answer.id).then((value) {
                              if (value['approved']) {
                                setState(() {
                                  answer.approvals++;
                                });
                              } else {
                                setState(() {
                                  answer.approvals--;
                                });
                              }
                              print(value);
                            });
                          },
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
      // floatingActionButton: BottomSheet(),
      bottomSheet: CommentWidget(
        onSendClicked: (val) {
          _showLoading(true);
          _appState.answerQuestion(val, widget.question.id).then((value) {
            print(value);
            _appState.fetchQuestionAnswers(widget.question.id).then((data) {
              setState(() {
                listAnswers = data;
              });
            });
            this.widget.onReply(widget.question);
            setState(() {
              totalAnswers++;
            });
            _showLoading(false);
          }).catchError((onError) {
            _showLoading(false);
          });
        },
      ),
      // FloatingActionButton.extended(
      //   onPressed: () {
      //     Scaffold.of(context).showBottomSheet<void>((context) {
      //       return Container(
      //         child: Column(
      //           children: <Widget>[
      //             TextfieldControllerWidget(
      //                 hint: 'Type someting', controller: _controller)
      //           ],
      //         ),
      //       );
      //     });
      //   },
      //   label: Text('Reply'),
      //   icon: Icon(Icons.add),
      // )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showLoading(bool isLoading) {
    if (mounted)
      setState(() {
        isSubmitting = isLoading;
      });
  }
}

class BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Scaffold.of(context).showBottomSheet<void>((context) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.PrimaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            height: 100,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextfieldControllerWidget(
                        hint: 'Type someting', controller: null),
                  ),
                ),
              ],
            ),
          );
        });
      },
      label: Text('Reply'),
      icon: Icon(Icons.add),
    );
  }
}
