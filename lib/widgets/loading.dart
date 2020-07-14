import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: AppTheme.PrimaryDarkColor,
      ),
    );
  }
}
