import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:twix/Api/api.dart';
import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';
import 'package:twix/Screens/note_editor.dart';
import 'package:twix/Widgets/custom_scroll_behaviour.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskWithBoard task;
  final TaskTableData taskFallBack;

  TaskDetailsScreen({this.task, this.taskFallBack});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool useFallBack = false;
  bool shouldDisable = false;

  @override
  void initState() {
    super.initState();
    useFallBack = widget.task == null;
    shouldDisable = useFallBack || useFallBack
        ? widget.taskFallBack.isDone
        : widget.task.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return FutureBuilder(
      future: database.taskDao.getTaskById(
          useFallBack ? widget.taskFallBack.id : widget.task.task.id),
      builder: (context, snapshot) {
        final task = snapshot.data ??
            TaskTableData(
              name: '',
              id: '',
              isDone: false,
              isSync: false,
              createdAt: DateTime.now(),
            );
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Details',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Created on ${DateFormat.yMMMEd().format(task.createdAt).toString()}',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        database.taskDao.deleteTask(
                            useFallBack ? widget.task : widget.task.task);
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.delete_outline,color: Colors.red,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: AbsorbPointer(
            absorbing: shouldDisable,
            child: ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 80,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Center(
                        child: ListTile(
                          leading: task.isDone
                              ? Icon(Icons.check_circle_outline)
                              : Icon(FontAwesomeIcons.circle),
                          title: Text(task.name),
                          trailing: database.taskDao.isMyDay(task.myDayDate)
                              ? Icon(Icons.star)
                              : Icon(Icons.star_border),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                child: ScrollConfiguration(
                                  behavior: CustomScrollBehaviour(),
                                  child: ListView(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              'Groups',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _buildGroupList(database),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          leading: Icon(Icons.assignment_ind),
                          title: task.assignedTo != null
                              ? Text('Assigned')
                              : Text('Assign task'),
                        ),
                        Divider(
                          indent: 70,
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.bell),
                          title: task.remindMe != null
                              ? Text(
                                  '${DateFormat.MMMEd().format(task.remindMe).toString()},'
                                  ' ${DateFormat.jm().format(task.remindMe).toString()}')
                              : Text('No reminder'),
                          onTap: () {},
                        ),
                        Divider(
                          indent: 70,
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: task.dueDate != null
                              ? Text(DateFormat.yMMMEd()
                                  .format(task.dueDate)
                                  .toString())
                              : Text('No due date'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoteEditor(task: task)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: task.notes != null || task.notes == ''
                              ? Text(task.notes)
                              : Text(
                                  'Add notes',
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  StreamBuilder _buildGroupList(TwixDB database) {
    return StreamBuilder(
        stream: database.groupDao.watchAllGroups(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final groups = snapshot.data ?? List();
          return ScrollConfiguration(
            behavior: CustomScrollBehaviour(),
            child: ListView.builder(
              itemCount: groups.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return GroupListTile(group: groups[index], task: widget.task);
              },
            ),
          );
        });
  }
}

class GroupListTile extends StatefulWidget {
  final GroupTableData group;
  final TaskWithBoard task;

  const GroupListTile({Key key, this.group, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GroupListTileState();
}

class GroupListTileState extends State<GroupListTile> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return FutureBuilder(
      future: database.taskDao.getTaskById(widget.task.task.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState ==
                ConnectionState.active) if (!snapshot.hasError) {
          if (snapshot.data.assignedTo == null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.group),
                title: Text(widget.group.name),
                onTap: () async {
                  database.taskDao.updateTask(
                      widget.task.task.copyWith(assignedTo: widget.group.id));
                  setState(() {});
                  await Api.deleteTask(widget.task.task.id);
                  await Api.createTask(
                      id: widget.task.task.id,
                      name: widget.task.task.name,
                      isDone: widget.task.task.isDone,
                      dueDate: widget.task.task.dueDate,
                      remindMe: widget.task.task.remindMe,
                      boardId: widget.task.board.id,
                      isAssigned: true,
                      groupId: widget.group.id);
                },
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.group),
              title: Text(widget.group.name),
              trailing: Icon(Icons.check),
              onTap: () async {
                database.taskDao.updateTask(widget.task.task
                    .createCompanion(false)
                    .copyWith(assignedTo: Value(null)));
                setState(() {});
                await Api.deleteTask(widget.task.task.id);
              },
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.group),
            title: Text(widget.group.name),
          ),
        );
      },
    );
  }
}
