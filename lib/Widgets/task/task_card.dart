import 'package:flutter/material.dart';
import 'package:twix/Screens/task_details.dart';

class TaskCard extends StatefulWidget {
  final String name;
  final String boardName;
  final bool isDone;
  const TaskCard({Key key, this.name, this.boardName,this.isDone}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconData isDayIcon = Icons.star_border;
  IconData isCompletedIcon = Icons.check_circle_outline;
  TextDecoration isStrikeThrough = TextDecoration.none;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(isCompletedIcon),
        title: Text(widget.name,style: TextStyle(decoration: isStrikeThrough),),
        subtitle: Text(widget.boardName),
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
            child: Icon(isDayIcon)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Screen(boardName: widget.boardName,taskName: widget.name,myDayIcon: isDayIcon,),
            ),
          );
        },
      ),
    );
  }
  void updater(){
    if(widget.isDone){
      setState(() {
        isCompletedIcon = Icons.check_circle;
        isStrikeThrough = TextDecoration.lineThrough;
      });
    }
  }
}
