import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';

class BoardTaskProgressBar extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;

  BoardTaskProgressBar({Key key, this.doneTasks, this.totalTasks});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width * 0.4;
    return Stack(
      children: <Widget>[
        Container(
          height: 10,
          width: width,
          decoration: BoxDecoration(
              color: Palette.boardProgressBarBackground,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
        Container(
          height: 10,
          width: width * (doneTasks / totalTasks),
          decoration: BoxDecoration(
              color: Palette.boardProgressBar,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
      ],
    );
  }
}
