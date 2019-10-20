import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;

import 'package:twix/Database/database.dart';

import 'package:twix/Database/DAOs/task_dao.dart';
import 'package:twix/Database/DAOs/assigned_task_dao.dart';

import 'package:twix/Screens/task_details.dart';

class TaskCard extends StatefulWidget {
  final TaskWithBoard task;
  final AssignedTaskWithUser assignedTask;

  const TaskCard({Key key, this.task, this.assignedTask}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconData isDayIcon = Icons.star_border;
  IconData isCompletedIcon = Icons.check_circle_outline;
  TextDecoration isStrikeThrough = TextDecoration.none;

  bool isAssignedToMe;
  TaskTableData task;
  BoardTableData board;

  @override
  void initState() {
    super.initState();
    isAssignedToMe = widget.assignedTask != null;
    if (isAssignedToMe) {
      task = widget.assignedTask.task;
    } else {
      task = widget.task.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: task.isDone
            ? Icon(Icons.check_circle_outline)
            : Icon(Icons.hourglass_empty),
        title: Text(task.name),
        subtitle:
            Text(isAssignedToMe ? 'Assigned Task' : widget.task.board.name),
        dense: true,
        trailing: database.taskDao.isMyDay(task.myDayDate)
            ? IconButton(
                icon: Icon(Icons.star),
                onPressed: () {
                  print(database.taskDao.isMyDay(task.myDayDate));
                  database.taskDao.updateTask(task
                      .createCompanion(false)
                      .copyWith(myDayDate: Value(null)));
                  setState(() {});
                },
              )
            : IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {
                  var today = DateTime.now();
                  today = DateTime(today.year, today.month, today.day);
                  database.taskDao
                      .updateTask(task.copyWith(myDayDate: today));
                  setState(() {});
                },
              ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                task: widget.task,
                taskFallBack: widget.assignedTask.task,
              ),
            ),
          );
        },
      ),
    );
  }

  void updater() {
    if (task.isDone) {
      setState(() {
        isCompletedIcon = Icons.check_circle;
        isStrikeThrough = TextDecoration.lineThrough;
      });
    }
  }
}
