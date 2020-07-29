import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snd_events/models/question.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/widgets/event_loading.dart';
import 'add_edit_question.dart';
import 'question_details.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Future<List<Question>> futureQuestions;
  AppState appState;
  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    futureQuestions = appState.fetchQuestions();
    appState.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Container(
          child: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                      child: EventLoadingWidget(
                        size: 60,
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white);
                });
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                      height: 30, width: 50, child: Text("Try again")),
                  onTap: () {
                    setState(() {
                      futureQuestions = appState.fetchQuestions();
                    });
                  },
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                      height: 30, width: 50, child: Text("No data found")),
                ),
              ),
            );
          }
          return _buildQuestionList(snapshot.data);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppUtils(context).nextPage(page: AddEditQuestionScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuestionList(List<Question> questions) {
    return ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var quest = questions[index];
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // Chip(label: Text('Q')),
                                Text(
                                  quest.question,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                            Chip(
                                avatar: Text('${quest.totalAnswers}'),
                                label: Text(
                                  'Replies',
                                  style: TextStyle(fontSize: 10),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(quest.postedBy),
                            Text(
                              quest.postedOn,
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                    thickness: 0.2,
                  )
                ],
              ),
            ),
            onTap: () {
              AppUtils(context).nextPage(
                  page: QuestionDetailsScreen(
                question: quest,
              ));
            },
          );
        });
  }
}
