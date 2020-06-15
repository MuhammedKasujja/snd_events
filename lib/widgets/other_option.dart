import 'package:flutter/material.dart';

class ORWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15,),
        Stack(
          children: <Widget>[
            Container(),
            Divider(thickness: 2,),
            Center(
              child: Container(color: Colors.white,child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text("OR", style: TextStyle(color: Colors.blue),),
              )),
            )
          ],
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}
