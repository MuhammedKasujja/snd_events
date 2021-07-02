import 'package:flutter/material.dart';

class EventLoadingWidget extends StatelessWidget {
  final double size;

  const EventLoadingWidget({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      height: size == null ? 100 : size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: size == null ? 100 : size,
            margin: EdgeInsets.only(right: 10),
            color: Colors.blue,
          ),
          Expanded(
              child: Container(
            color: Colors.grey[300],
          ))
        ],
      ),
    );
  }
}
