import 'package:flutter/material.dart';
import 'package:snd_events/utils/app_theme.dart';

class FancyCommunityItemWidget extends StatelessWidget {
  final double height;

  const FancyCommunityItemWidget({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: this.height == null ? 150 : this.height,
            width: 120,
            decoration: BoxDecoration(
                color: AppTheme.PrimaryDarkColor,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
                //shape:
                ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 6, right: 10, left: 10),
                    child: Text(
                      "Join",
                      style: TextStyle(color: AppTheme.PrimaryDarkColor),
                    ),
                  )))
        ],
      ),
    );
  }
}
