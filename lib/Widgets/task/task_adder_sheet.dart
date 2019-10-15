import 'package:flutter/material.dart';
import 'package:twix/Widgets/task/task_details.dart';

class TaskAdderSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 100),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8, bottom: 8, right: 5),
                      child: TextField(
                        expands: true,
                        decoration: InputDecoration(
                          hintText: 'Task Title',
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                        maxLines: null,
                      ),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {})),
                ],
              ),
            ),
            Container(height: 51,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  TaskDetails(
                    iconData: Icons.calendar_today,
                    text: 'Set due date',
                  ),
                  TaskDetails(
                    iconData: Icons.add_alert,
                    text: 'Remind Me',
                  ),
                  TaskDetails(
                    iconData: Icons.note,
                    text: 'Add note',
                  ),
                  TaskDetails(
                    iconData: Icons.calendar_today,
                    text: 'Set due date',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
