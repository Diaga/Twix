import 'package:flutter/material.dart';
import 'package:twix/Screens/task_details.dart';


class TaskCard extends StatelessWidget {
  final String name;
  final String boardName;

  const TaskCard({Key key, this.name, this.boardName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.hourglass_empty),
        title: Text(name),
        subtitle: Text(boardName),
        dense: true,
        trailing: Icon(Icons.star_border),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Screen()));
        },
      ),
    );
  }
}
