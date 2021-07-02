import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/widgets/conditions_hlist.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Container(
        height: 50,
        child: appState.childConditions != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appState.childConditions.length,
                itemBuilder: (context, index) {
                  var condition = appState.childConditions[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Center(
                                child: Text(
                              '${condition.name}',
                              style: TextStyle(color: Colors.black54),
                            )),
                          ),
                        ),
                      ),
                      onTap: () {
                        print('Yes clicked');
                      },
                    ),
                  );
                })
            : ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Shimmer.fromColors(
                      child: LoadingConditionHList(),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white);
                }) //LoadingWidget(),
        );
  }
}
