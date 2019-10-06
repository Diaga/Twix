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

  _BoardState({Key key, this.heading, this.doneTasks, this.totalTasks});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(1.0)),
        border: Border.all(color: Palette.board_borders),
      ),
      width: size.width * 0.4,
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Align(
            child: BoardHeading(heading: heading),
          ),
          Align(
            child: BoardTaskCounter(
              doneTasks: doneTasks,
              totalTasks: totalTasks,
            ),
          ),
          Align(
            child: BoardTaskProgressBar(
              doneTasks: doneTasks,
              totalTasks: totalTasks,
            ),
          )
        ],
      ),
    );
  }
}
