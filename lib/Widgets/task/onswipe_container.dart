import 'package:flutter/material.dart';

class OnSwipeContainer extends StatelessWidget {
  final Color color;

  OnSwipeContainer({this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: color,
    );
  }
}
