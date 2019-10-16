import 'package:flutter/material.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

import 'package:twix/Database/database.dart';
import 'package:provider/provider.dart';

import 'package:twix/Widgets/task/onswipe_container.dart';
import 'package:twix/Widgets/task/task_adder_sheet.dart';
import 'package:twix/Widgets/task/task_card.dart';

class TaskScreen extends StatefulWidget {
  final String boardId;
  final String action;

  TaskScreen({this.boardId, this.action = 'normal'});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool getBoardName;

  @override
  void initState() {
    super.initState();
    getBoardName = widget.action == 'normal';
  }

//  BoardTableData getBoard(TwixDB database) {
//    return getBoardName
//        ? await database.boardDao.getBoardById(widget.boardId)
//        : await database.boardDao.getMyTasksBoard();
//  }

  @override
  Widget build(BuildContext context) {
    final TwixDB database = Provider.of<TwixDB>(context);
//    final BoardTableData board = getBoard(database);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: (context),
              isScrollControlled: true,
              builder: (context) => TaskAdderSheet());
        },
        backgroundColor: Color(0xFF3C6AFF),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 18),
                      child: Text(
                        'board.name',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20),
                      child: Text('Oct 5, 2019'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF3C6AFF),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '2',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '/',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '6',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: _buildTaskList(context, database),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<TaskWithBoard>> _buildTaskList(
      BuildContext context, TwixDB database) {
    return StreamBuilder(
      stream: database.taskDao.watchAllMyDayTasks(),
      builder: (context, AsyncSnapshot<List<TaskWithBoard>> snapshot) {
        final tasks = snapshot.data ?? List();
        return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final taskItem = tasks[index];
              return _taskCard(taskItem, database);
            });
      },
    );
  }

  Widget _taskCard(TaskWithBoard taskItem, TwixDB database) {
    final TaskCard taskCard =
        TaskCard(name: taskItem.task.name, boardName: taskItem.board.name);
    return Dismissible(
      key: ValueKey(taskCard.hashCode),
      background: OnSwipeContainer(
        color: Colors.blue,
        iconData: Icons.check,
        alignment: Alignment.centerLeft,
      ),
      child: taskCard,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          // Logic to update the task to isDone
          database.taskDao.updateTask(taskItem.task.copyWith(isDone: true));

          // Display snack bar
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Completed"),
              duration: Duration(milliseconds: 600),
            ),
          );
        } else if (direction == DismissDirection.endToStart) {
          // Logic to delete the task
          database.taskDao.deleteTask(taskItem.task);

          // Display snack bar
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Deleted"),
              duration: Duration(milliseconds: 600),
            ),
          );
        }
      },
      secondaryBackground: OnSwipeContainer(
        color: Colors.red,
        iconData: Icons.delete,
        alignment: Alignment.centerRight,
      ),
    );
  }
}
