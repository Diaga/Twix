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
        Row(
          children: <Widget>[
            Board(heading: "WORL", doneTasks: 1, totalTasks: 5),
          ],
        )
      ],
    );
  }
}
