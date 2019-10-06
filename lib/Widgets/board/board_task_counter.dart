import 'package:flutter/material.dart';


class BoardTaskCounter extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;

  BoardTaskCounter({Key key, this.doneTasks, this.totalTasks});

  @override
  Widget build(BuildContext context) {
    return Text('$doneTasks of $totalTasks completed!');
  }
}
