import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Container(
            child: Center(
                child: Container(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator()))));
  }
}
