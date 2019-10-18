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
  IconData isDayIcon = Icons.star_border;
  IconData isCompletedIcon = Icons.check_circle_outline;
  TextDecoration isStrikeThrough = TextDecoration.none;
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
                if (isDayIcon == Icons.star_border) {
                  isDayIcon = Icons.star;
                } else {
                  isDayIcon = Icons.star_border;
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
  void updater(){
    if(widget.task.task.isDone){
      setState(() {
        isCompletedIcon = Icons.check_circle;
        isStrikeThrough = TextDecoration.lineThrough;
      });
    }
  }
}
