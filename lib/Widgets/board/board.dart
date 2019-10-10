import 'package:flutter/material.dart';

import 'package:twix/Screens/task_screen.dart';

import 'package:twix/Widgets/board/board_heading.dart';
import 'package:twix/Widgets/board/board_task_counter.dart';
import 'package:twix/Widgets/board/board_task_progress_bar.dart';

import 'package:twix/Database/Tables/board_table.dart';

class Board extends StatefulWidget {
  final int id;
  final String heading;
  final int doneTasks;
  final int totalTasks;

  Board({Key key, this.id, this.heading, this.doneTasks, this.totalTasks})
      : super(key: key);

  Board.fromObject(BoardTable boardTable)
      : this.id = boardTable.id,
        this.heading = boardTable.name,
        this.doneTasks = 1,
        this.totalTasks = 5;

  @override
  State<StatefulWidget> createState() => _BoardState(
      id: id, heading: heading, doneTasks: doneTasks, totalTasks: totalTasks);
}

class _BoardState extends State<Board> {
  final int id;
  final String heading;
  final int doneTasks;
  final int totalTasks;

  _BoardState({
    Key key,
    @required this.id,
    @required this.heading,
    @required this.doneTasks,
    @required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(
              boardId: id,
            ),
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
