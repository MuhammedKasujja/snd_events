import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class TextfieldWidget extends StatelessWidget {
  final Function(String) onTextChange;
  final String hint;
  final bool isPassword;
  final TextInputType inputType;

  const TextfieldWidget(
      {Key key,
      @required this.onTextChange,
      @required this.hint,
      this.isPassword,
      this.inputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          keyboardType:
              this.inputType == null ? TextInputType.text : this.inputType,
          obscureText: this.isPassword == null ? false : this.isPassword,
          onChanged: this.onTextChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide()
            ),
              //hintText: this.hint,
              labelText: this.hint,
              labelStyle: TextStyle(color: AppTheme.PrimaryDarkColor)),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
