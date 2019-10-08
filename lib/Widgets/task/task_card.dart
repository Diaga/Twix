import 'package:flutter/material.dart';
import 'package:twix/Screens/task_details.dart';

class TaskCard extends StatelessWidget {
  final String title;

  const TaskCard({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.check_circle_outline),
        title: Text(title),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Screen()));
        },
      ),
    );
  }
}
