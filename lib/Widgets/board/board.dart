import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';

import 'package:twix/Widgets/board/board_heading.dart';
import 'package:twix/Widgets/board/board_task_counter.dart';
import 'package:twix/Widgets/board/board_task_progress_bar.dart';

class Board extends StatefulWidget {
  final String heading;
  final int doneTasks;
  final int totalTasks;

  Board({Key key, this.heading, this.doneTasks, this.totalTasks})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoardState(
      heading: heading, doneTasks: doneTasks, totalTasks: totalTasks);
}

class _BoardState extends State<Board> {
  final String heading;
  final int doneTasks;
  final int totalTasks;

  _BoardState(
      {Key key,
      @required this.heading,
      @required this.doneTasks,
      @required this.totalTasks});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Palette.boardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Palette.boardShadow,
              offset: Offset(3, 3),
              blurRadius: 10,
            ),
          ]),
      width: size.width * 0.4,
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Align(
            child: BoardHeading(heading: heading),
            alignment: Alignment(-0.7, -0.85),
          ),
          Align(
            child: BoardTaskCounter(
              doneTasks: doneTasks,
              totalTasks: totalTasks,
            ),
            alignment: Alignment(-0.6, 0.3),
          ),
          Align(
            child: BoardTaskProgressBar(
              doneTasks: doneTasks,
              totalTasks: totalTasks,
            ),
            alignment: Alignment(-0.9, 0.8),
          )
        ],
      ),
    );
  }
}
