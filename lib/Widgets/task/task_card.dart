import 'package:flutter/material.dart';
import 'package:twix/Screens/task_details.dart';

import 'package:twix/Database/Tables/task_table.dart';

class TaskCard extends StatelessWidget {
  final int id;
  final String name;
  final bool isDone;
  final int boardId;

  TaskCard({this.id, this.name, this.isDone, this.boardId});

  TaskCard.fromObject(TaskTable taskTable)
      : this.id = taskTable.id,
        this.name = taskTable.name,
        this.isDone = taskTable.getIsDone,
        this.boardId = taskTable.boardId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.check_circle_outline),
        title: Text(name),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Screen()));
        },
      ),
    );
  }
}
