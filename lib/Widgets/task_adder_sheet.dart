import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Widgets/task_details.dart';

class TaskAdderSheet extends StatefulWidget {
  final String boardId;
  final String action;

  const TaskAdderSheet(
      {Key key, @required this.boardId, this.action = 'normal'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskAdderSheetState();
}

class _TaskAdderSheetState extends State<TaskAdderSheet> {
  final TextEditingController textEditingController = TextEditingController();

  DateTime today = DateTime.now();
  DateTime dueDate;

  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  DateTime reminderDate;
  TimeOfDay reminderTime;

  @override
  void initState() {
    super.initState();
    today = DateTime(today.year, today.month, today.day);
  }

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
                      onPressed: () async {
                        final today = DateTime.now();
                        if (textEditingController.text.isNotEmpty) {
                          widget.action == 'normal'
                              ? database.taskDao.insertTask(TaskTableCompanion(
                                  id: Value(Uuid().v4()),
                                  name: Value(textEditingController.text),
                                  dueDate: Value(dueDate),
                                  boardId: Value(widget.boardId),
                                  createdAt: Value(today)))
                              : database.taskDao.insertTask(TaskTableCompanion(
                                  id: Value(Uuid().v4()),
                                  name: Value(textEditingController.text),
                                  boardId: Value(widget.boardId),
                                  dueDate: Value(dueDate),
                                  myDayDate: Value(DateTime(
                                      today.year, today.month, today.day)),
                                  createdAt: Value(today)));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
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
                    text: dueDate == null
                        ? 'Set due date'
                        : DateFormat.yMMMEd().format(dueDate).toString(),
                    callBack: selectDate,
                  ),
                  TaskDetails(
                    iconData: Icons.add_alert,
                    text: 'Remind Me',
                    callBack: selectTime,
                  ),
                  TaskDetails(
                    iconData: Icons.note,
                    text: 'Add notes',
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

  Future selectDate() async {
    var selected = await showDatePicker(
        context: (context),
        initialDate: initialDate,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(2050, 1));
    if (selected != null && selected != dueDate)
      setState(() {
        dueDate = selected;
      });
  }

  Future selectTime() async {
    var selected =
        await showTimePicker(context: context, initialTime: initialTime);
    if (selected != null && selected != reminderTime) {
      setState(() {
        reminderTime = selected;
      });
    }
  }
}
