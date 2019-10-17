import 'package:flutter/material.dart';
import 'package:twix/Screens/task_details.dart';

class TaskCard extends StatefulWidget {
  final String name;
  final String boardName;

  const TaskCard({Key key, this.name, this.boardName}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconData myDayIcon = Icons.star_border;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.hourglass_empty),
        title: Text(widget.name),
        subtitle: Text(widget.boardName),
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
            child: Icon(myDayIcon)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Screen(boardName: widget.boardName,taskName: widget.name,myDayIcon: myDayIcon,),
            ),
          );
        },
      ),
    );
  }
}
