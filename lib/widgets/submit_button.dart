import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class SubmitButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButtonWidget({Key key, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
     // color: AppTheme.APP_COLOR,
     textColor:AppTheme.APP_COLOR,
      onPressed: this.onPressed,
      child: Text("Submit"),
    );
  }
}
