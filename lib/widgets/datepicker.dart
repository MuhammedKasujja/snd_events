import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snd_events/utils/app_theme.dart';

class DatepickerWidget extends StatelessWidget {
  final TextEditingController controller;
  final format = DateFormat("yyyy-MM-dd");

  DatepickerWidget({Key key, @required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Text('Basic date field (${format.pattern})'),
      DateTimeField(
        controller: this.controller,
        resetIcon: null,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.event_note),
            labelText: 'Date',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: AppTheme.PrimaryDarkColor)
            ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
