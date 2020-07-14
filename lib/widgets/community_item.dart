import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/screens/community_details.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';

class CommunityItemWidget extends StatelessWidget {
  final double height;
  final Community community;

  const CommunityItemWidget({Key key, this.height, @required this.community})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: this.height == null ? 150 : this.height,
              width: 200,
              decoration: BoxDecoration(
                  color: AppTheme.PrimaryDarkColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                      image: NetworkImage(this.community.image),
                      fit: BoxFit.fill)
                  //shape:
                  ),
            ),
            // Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: Container(
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(20),
            //                 bottomRight: Radius.circular(20))),
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //               top: 6, bottom: 6, right: 10, left: 10),
            //           child: Text(
            //             "Join",
            //             style: TextStyle(color: AppTheme.PrimaryDarkColor),
            //           ),
            //         )))
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: ClipRect(
                  // child: BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 0.9),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          community.name,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 20),
                        ),
                      ),
                    ),
                 // ),
                ))
          ],
        ),
      ),
      onTap: () {
        AppUtils(context)
            .nextPage(page: CommunityDetailsScreen(community: this.community));
      },
    );
  }
}
