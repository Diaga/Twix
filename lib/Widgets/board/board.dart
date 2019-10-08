import 'package:flutter/material.dart';
import 'package:twix/Screens/task_screen.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BoardHeading(heading: heading),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BoardTaskCounter(
                doneTasks: doneTasks,
                totalTasks: totalTasks,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: BoardTaskProgressBar(
                doneTasks: doneTasks,
                totalTasks: totalTasks,
              ),
            )
          ],
        ),
      ),
    );
  }
}
