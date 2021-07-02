import 'package:flutter/material.dart';

class EventShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      width: _width,
      child: Column(
        children: [
          Container(
            height: 150,
            width: _width,
            color: Colors.grey,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 20,
            width: _width - 300,
            color: Colors.grey,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 15,
                width: 200,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 200,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 15,
                    width: 200,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
