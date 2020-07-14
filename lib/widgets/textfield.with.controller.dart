import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class TextfieldControllerWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const TextfieldControllerWidget({
    Key key,
    @required this.hint,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: this.controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            //hintText: this.hint,
            labelText: this.hint,
            labelStyle: TextStyle(color: AppTheme.PrimaryDarkColor),
            // suffixIcon: this.controller.text.isEmpty
            //     ? Container(
            //       height: 10,
            //       width: 10,
            //       child: CircularProgressIndicator(
            //           backgroundColor: AppTheme.PrimaryDarkColor,
            //         ),
            //     )
            //     : Opacity(opacity: 0.0)
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
