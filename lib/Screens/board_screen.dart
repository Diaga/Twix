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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BoardRow(
          widgets: <Widget>[
            Board(heading: 'Board 1', doneTasks: 1, totalTasks: 5,),
            Board(heading: 'Board 2', doneTasks: 3, totalTasks: 6,),
          ],
        )
      ],
    );
  }
}
