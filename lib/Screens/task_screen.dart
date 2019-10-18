import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

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
  String boardId;
  bool getBoardName;
  bool isMyDay;
  bool isAssignedToMe;

  @override
  void initState() {
    super.initState();
    getBoardName = widget.action == 'normal';
    isMyDay = widget.action == 'My Day';
    isAssignedToMe = widget.action == 'Assigned To Me';
  }

  Future<BoardTableData> getBoard(TwixDB database) async {
    return getBoardName
        ? await database.boardDao.getBoardById(widget.boardId)
        : await database.boardDao.getMyTasksBoard();
  }

  // TODO: Update for assigned to me
  Stream<List<TaskTableData>> watchAllTaskListNoJoin(TwixDB database) {
    return getBoardName
        ? database.taskDao.watchAllTasksByBoardIdNoJoin(widget.boardId)
        : isMyDay
            ? database.taskDao.watchAllMyDayTasks()
            : database.taskDao.watchAllMyDayTasks();
  }

  Stream<List<TaskTableData>> watchDoneTaskList(TwixDB database) {
    return getBoardName
        ? database.taskDao.watchDoneTasksByBoardId(widget.boardId)
        : isMyDay
            ? database.taskDao.watchDoneMyDayTasks()
            : database.taskDao.watchDoneMyDayTasks();
  }

  Stream<List<TaskWithBoard>> watchAllTaskList(TwixDB database) {
    return getBoardName
        ? database.taskDao.watchAllTasksByBoardId(widget.boardId)
        : isMyDay
            ? database.taskDao.watchAllMyDayTasks()
            : database.taskDao.watchAllMyDayTasks();
  }

  @override
  Widget build(BuildContext context) {
    final TwixDB database = Provider.of<TwixDB>(context);
    final Future<BoardTableData> boardFuture = getBoard(database);

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
        onPressed: () async {
          boardId = (await getBoard(database)).id;
          showModalBottomSheet(
              context: (context),
              isScrollControlled: true,
              builder: (context) => TaskAdderSheet(
                    boardId: boardId,
                    action: widget.action,
                  ));
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
                FutureBuilder(
                  future: boardFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return _buildBoardColumn('', '');
                      }
                      DateTime dateTime = snapshot.data.createdAt;
                      DateFormat format = DateFormat.yMMMd();
                      return _buildBoardColumn(
                          snapshot.data.name, format.format(dateTime));
                    }
                    return _buildBoardColumn('', '');
                  },
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
                        StreamBuilder(
                            stream: watchDoneTaskList(database),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState
                                      .active) if (!snapshot.hasError) {
                                final data = snapshot.data ?? List();
                                return _buildCountDoneTasks(
                                    data.length.toString());
                              }
                              return _buildCountDoneTasks('0');
                            }),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '/',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        StreamBuilder(
                            stream: watchAllTaskList(database),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState
                                      .active) if (snapshot.hasError) {
                                final data = snapshot.data ?? List();
                                return _buildCountAllTasks(
                                    data.length.toString());
                              }
                              return _buildCountAllTasks('0');
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: _buildTaskList(context, database)),
        ],
      ),
    );
  }

  StreamBuilder<List<TaskWithBoard>> _buildTaskList(
      BuildContext context, TwixDB database) {
    return StreamBuilder(
        stream: watchAllTaskList(database),
        builder: (context, AsyncSnapshot<List<TaskWithBoard>> snapshot) {
          final tasks = snapshot.data ?? List();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final taskItem = tasks[index];
                return _buildTaskCard(taskItem, database);
              },
            );
          }
        });
  }

  Widget _buildTaskCard(TaskWithBoard taskItem, TwixDB database) {
    final TaskCard taskCard = TaskCard(
      task: taskItem,
    );
    IconData isCompletedIcon = Icons.check_circle_outline;
    return Builder(
        builder: (context) => Dismissible(
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
                  database.taskDao
                      .updateTask(taskItem.task.copyWith(isDone: true));

                  // Display snack bar
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Done"),
                      duration: Duration(milliseconds: 600),
                    ),
                  );
                  setState(() {
                    isCompletedIcon = Icons.check_circle;
                  });
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
            ));
  }

  Widget _buildBoardColumn(String boardName, String createdAt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          child: Text(
            boardName,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
          child: Text(createdAt),
        ),
      ],
    );
  }

  Widget _buildCountDoneTasks(String count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        count,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildCountAllTasks(String count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          count,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
