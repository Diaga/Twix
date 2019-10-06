import 'package:flutter/material.dart';


class OnSwipeContainer extends StatelessWidget {
  final Color color;

  OnSwipeContainer({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}