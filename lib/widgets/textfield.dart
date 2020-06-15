import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final Function(String) onTextChange;
  final String hint;

  const TextfieldWidget(
      {Key key, @required this.onTextChange, @required this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: this.onTextChange,
          decoration: InputDecoration(//hintText: this.hint,
          labelText: this.hint),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
