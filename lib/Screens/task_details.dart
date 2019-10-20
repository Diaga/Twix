import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;

import 'package:twix/Api/api.dart';
import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

import 'package:twix/Screens/note_editor.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskWithBoard task;

  TaskDetailsScreen({this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task.board.name,
          style: TextStyle(color: Colors.black),
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
                      child: Text('Created five minutes ago'),
                    )),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Icon(Icons.delete_outline),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              margin: EdgeInsets.zero,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text(widget.task.task.name),
                  trailing: database.taskDao.isMyDay(widget.task.task.myDayDate)
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          child: _buildGroupList(database),
                        ));
              },
              leading: Icon(Icons.assignment_ind),
              title: Text('Assign task'),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add_alert),
                  title: Text('Remind Me'),
                ),
                Divider(
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: widget.task.task.dueDate != null
                      ? Text(widget.task.task.dueDate.toString())
                      : Text('Add due date'),
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
                          builder: (context) => NoteEditor(task: widget.task)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.task.task.notes != null ||
                          widget.task.task.notes == ''
                      ? widget.task.task.notes
                      : 'Add notes'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder _buildGroupList(TwixDB database) {
    return StreamBuilder(
      stream: database.groupDao.watchAllGroups(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              return GroupListTile(
                  group: snapshot.data[index], task: widget.task);
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
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
              return ListTile(
                  leading: Icon(Icons.group),
                  title: Text(widget.group.name),
                  onTap: () async {
                    var response = await Api.createTask(
                        id: widget.task.task.id,
                        name: widget.task.task.name,
                        isDone: widget.task.task.isDone,
                        dueDate: widget.task.task.dueDate,
                        remindMe: widget.task.task.remindMe,
                        boardId: widget.task.board.id,
                        isAssigned: true,
                        groupId: widget.group.id);
                    print(response.body);
                    database.taskDao.updateTask(
                        widget.task.task.copyWith(assignedTo: widget.group.id));
                    setState(() {});
                  });
            }
            return ListTile(
              leading: Icon(Icons.group),
              title: Text(widget.group.name),
              trailing: Icon(Icons.check),
              onTap: () async {
                Api.deleteTask(widget.task.task.id);
                database.taskDao.updateTask(widget.task.task
                    .createCompanion(false)
                    .copyWith(assignedTo: Value(null)));
                setState(() {});
              },
            );
          }
          return ListTile(
            leading: Icon(Icons.group),
            title: Text(widget.group.name),
          );
        });
  }
}
