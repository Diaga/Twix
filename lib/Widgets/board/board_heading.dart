import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';

class BoardHeading extends StatelessWidget {
  final String heading;

  BoardHeading({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading, style: TextStyle(
      color: Palette.boardHeading,
      fontWeight: FontWeight.bold,
      fontSize: 20
    ),);
  }
}
