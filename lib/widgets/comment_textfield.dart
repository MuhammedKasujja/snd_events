import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class CommentWidget extends StatelessWidget {
  final Function() onSendClicked;

  const CommentWidget({Key key, @required this.onSendClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: TextField(
          decoration: InputDecoration(
               border: InputBorder.none,
              hintText: 'comment ....',
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppTheme.PrimaryDarkColor,
                  ),
                  onPressed: this.onSendClicked)),
        ),
      ),
    );
  }
}
