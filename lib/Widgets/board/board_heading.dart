import 'package:flutter/material.dart';

class BoardHeading extends StatelessWidget {
  final String heading;

  BoardHeading({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading);
  }
}
