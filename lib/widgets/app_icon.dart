import 'package:flutter/material.dart';
import 'package:snd_events/utils/constants.dart';

class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //color: Colors.blue,
          // width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text(
              Constants.APP_NAME,
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
