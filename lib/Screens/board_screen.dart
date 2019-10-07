import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';

import 'package:twix/Widgets/board/board.dart';
import 'package:twix/Widgets/board/board_row.dart';

class BoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: <Widget>[
        Board(
          heading: 'Board 1',
          doneTasks: 1,
          totalTasks: 5,
        ),
        Board(
          heading: 'Board 2',
          doneTasks: 3,
          totalTasks: 6,
        ),
        Board(
          heading: 'Board 3',
          doneTasks: 2,
          totalTasks: 3,
        ),
        Board(
          heading: 'Board 4',
          doneTasks: 4,
          totalTasks: 6,
        ),
        Board(
          heading: 'Board 5',
          doneTasks: 6,
          totalTasks: 6,
        ),
        Board(
          heading: 'Board 6',
          doneTasks: 1,
          totalTasks: 4,
        ),
        Board(
          heading: 'Board 7',
          doneTasks: 1,
          totalTasks: 10,
        ),
      ],
    );
  }
}
