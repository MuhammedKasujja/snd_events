import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class DescriptionTextfieldWidget extends StatelessWidget {
  final Function(String) onTextChange;

  const DescriptionTextfieldWidget({Key key, @required this.onTextChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: this.onTextChange,
      minLines: 5,
      maxLines: 10,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
          labelStyle: TextStyle(color: AppTheme.PrimaryDarkColor)),
    );
  }
}
