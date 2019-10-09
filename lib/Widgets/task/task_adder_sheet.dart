import 'package:flutter/material.dart';


class TaskAdderSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String taskTitle;
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 100),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 30),
              child: Text('Add Task'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Task Title',
                ),
                autofocus: true,
                onChanged: (value) {
                  taskTitle = value;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 2, top: 10),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, taskTitle);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
