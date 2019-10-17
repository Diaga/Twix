import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:twix/Database/database.dart';
import 'package:twix/Widgets/task/task_details.dart';
import 'package:uuid/uuid.dart';

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

  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  DateTime dueDate;
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
                                  id: moor.Value(Uuid().v4()),
                                  name: moor.Value(textEditingController.text),
                                  boardId: moor.Value(widget.boardId),
                                  createdAt: moor.Value(today)))
                              : database.taskDao.insertTask(TaskTableCompanion(
                                  id: moor.Value(Uuid().v4()),
                                  name: moor.Value(textEditingController.text),
                                  boardId: moor.Value(widget.boardId),
                                  myDayDate: moor.Value(DateTime(
                                      today.year, today.month, today.day)),
                                  createdAt: moor.Value(today)));
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
                    text: 'Set due date',
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
