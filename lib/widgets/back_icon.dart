import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class BackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 60,
      child: InkWell(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppTheme.PrimaryColor,
              borderRadius: BorderRadius.circular(30)),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
