import 'package:flutter/material.dart';

import 'package:twix/Palette/palette.dart';


class BoardTaskProgressBar extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;

  BoardTaskProgressBar({Key key, this.doneTasks, this.totalTasks});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator();
  }
}
