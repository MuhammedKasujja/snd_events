import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class ORWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Stack(
          children: <Widget>[
            Container(),
            Divider(
              thickness: 2,
            ),
            Center(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Text(
                      "OR",
                      style: TextStyle(
                          color: AppTheme.PrimaryDarkColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
