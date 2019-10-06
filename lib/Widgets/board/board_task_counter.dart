import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';

class BoardTaskCounter extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;

  BoardTaskCounter({Key key, this.doneTasks, this.totalTasks});

  @override
  Widget build(BuildContext context) {
    return Text('$doneTasks of $totalTasks completed!', style: TextStyle(
      color: Palette.boardTaskCounter,
      fontStyle: FontStyle.italic,
      fontSize: 15,
    ),);
  }
}
