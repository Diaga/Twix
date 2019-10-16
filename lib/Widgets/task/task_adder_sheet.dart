import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

import 'package:twix/Database/database.dart';

import 'package:twix/Widgets/task/task_details.dart';

class TaskAdderSheet extends StatefulWidget {
  final String boardId;

  const TaskAdderSheet({Key key, this.boardId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskAdderSheetState();
}

class _TaskAdderSheetState extends State<TaskAdderSheet> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
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
                          hintText: 'Task name',
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                        maxLines: null,
                        controller: textEditingController,
                      ),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {
                            if (textEditingController.text.isNotEmpty)
                              database.taskDao.insertTask(TaskTableCompanion(
                                  name: moor.Value(textEditingController.text),
                                  boardId: moor.Value(widget.boardId)));
                          })),
                ],
              ),
            ),
            Container(
              height: 51,
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

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
