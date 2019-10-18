import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

import 'package:twix/Screens/task_details.dart';

class TaskCard extends StatefulWidget {
  final TaskWithBoard task;

  const TaskCard({Key key, this.task}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconData myDayIcon = Icons.star_border;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.hourglass_empty),
        title: Text(widget.task.task.name),
        subtitle: Text(widget.task.board.name),
        dense: true,
        trailing: GestureDetector(
            onTap: () {
              setState(() {
                if (myDayIcon == Icons.star_border) {
                  myDayIcon = Icons.star;
                } else {
                  myDayIcon = Icons.star_border;
                }
              });
            },
            child: database.taskDao.isMyDay(widget.task.task.myDayDate)
                ? Icon(Icons.star)
                : Icon(Icons.star_border)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                task: widget.task,
              ),
            ),
          );
        },
      ),
    );
  }
}
