import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';
import 'package:twix/Database/DAOs/assigned_task_dao.dart';

import 'package:twix/Screens/home_screen.dart';
import 'package:twix/Widgets/custom_scroll_behaviour.dart';
import 'package:twix/Widgets/onswipe_container.dart';
import 'package:twix/Widgets/task_adder_sheet.dart';
import 'package:twix/Widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  final String boardId;
  final String action;
  final UserTableData loggedInUser;

  TaskScreen({this.boardId, this.action = 'normal', this.loggedInUser});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String boardId;
  bool getBoardName;
  bool isMyDay;
  bool isAssignedToMe;

  BoardTableData boardData;
  List doneTasks;
  List allTasks;
  List<TaskWithBoard> tasks;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    getBoardName = widget.action == 'normal';
    isMyDay = widget.action == 'My Day';
    isAssignedToMe = widget.action == 'Assigned To Me';

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future showNotification({String title, String task, DateTime time}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel ID', 'channel Name', 'channel Description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      title,
      task,
      time,
      platformChannelSpecifics,
    );
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future<BoardTableData> getBoard(TwixDB database) async {
    return getBoardName
        ? await database.boardDao.getBoardById(widget.boardId)
        : await database.boardDao.getMyTasksBoard();
  }

  Stream<List<TaskTableData>> watchAllTaskListNoJoin(TwixDB database) {
    return getBoardName
        ? database.taskDao.watchAllTasksByBoardIdNoJoin(widget.boardId)
        : isMyDay ? database.taskDao.watchAllMyDayTasks() : null;
  }

  Stream<List<TaskTableData>> watchDoneTaskList(TwixDB database) {
    return getBoardName
        ? database.taskDao.watchDoneTasksByBoardId(widget.boardId)
        : isMyDay ? database.taskDao.watchDoneMyDayTasks() : null;
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: ThemeData
            .light()
            .scaffoldBackgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              database.boardDao.deleteBoard(boardData);
              Navigator.pop(context);
            },
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: isAssignedToMe
          ? null
          : FloatingActionButton(
        onPressed: () async {
          boardId = (await getBoard(database)).id;
          showModalBottomSheet(
              context: (context),
              isScrollControlled: true,
              builder: (context) =>
                  TaskAdderSheet(
                      boardId: boardId,
                      action: widget.action,
                      showNotification: showNotification
                  ));
        },
        backgroundColor: Color(0xFF3C6AFF),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder(
                  future: boardFuture,
                  builder: (context, snapshot) {
                    DateFormat format = DateFormat.yMMMd();
                    if (isAssignedToMe)
                      return _buildBoardColumn(
                          'Assigned To Me', format.format(DateTime.now()));
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasError) {
                        boardData = snapshot.data;
                        DateTime dateTime = boardData?.createdAt;
                        return _buildBoardColumn(
                            boardData == null ? '' : boardData.name,
                            format.format(
                                dateTime == null ? DateTime.now() : dateTime));
                      }
                    }
                    return _buildBoardColumn(
                        boardData != null ? boardData.name : '',
                        boardData != null
                            ? format.format(boardData.createdAt)
                            : '');
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
                        isAssignedToMe
                            ? StreamBuilder(
                          stream: database.assignedTaskDao
                              .watchDoneAssignedTasksByUserId(
                              widget.loggedInUser.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done ||
                                snapshot.connectionState ==
                                    ConnectionState.active) {
                              return _buildCountDoneTasks(
                                  snapshot.data == null
                                      ? '0'
                                      : snapshot.data.length.toString());
                            }
                            return _buildCountAllTasks('0');
                          },
                        )
                            : StreamBuilder(
                            stream: watchDoneTaskList(database),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState
                                      .active) if (!snapshot.hasError) {
                                doneTasks = snapshot.data ?? List();
                                return _buildCountDoneTasks(
                                    doneTasks?.length.toString());
                              }
                              return _buildCountDoneTasks(doneTasks != null
                                  ? doneTasks.length.toString()
                                  : '');
                            }),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '/',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        isAssignedToMe
                            ? StreamBuilder(
                          stream: database.assignedTaskDao
                              .watchAllAssignedTasksByUserId(
                              widget.loggedInUser.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done ||
                                snapshot.connectionState ==
                                    ConnectionState.active) {
                              return _buildCountAllTasks(
                                  snapshot.data == null
                                      ? '0'
                                      : snapshot.data.length.toString());
                            }
                            return _buildCountAllTasks('0');
                          },
                        )
                            : StreamBuilder(
                            stream: watchAllTaskList(database),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState
                                      .active) if (!snapshot.hasError) {
                                allTasks = snapshot.data ?? List();
                                return _buildCountAllTasks(
                                    allTasks.length.toString());
                              }
                              return _buildCountAllTasks(allTasks != null
                                  ? allTasks.length.toString()
                                  : '');
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.65,
              child: isAssignedToMe
                  ? _buildAssignedTaskList(context, database)
                  : _buildTaskList(context, database)),
        ],
      ),
    );
  }

  StreamBuilder<List<AssignedTaskWithUser>> _buildAssignedTaskList(
      BuildContext context, TwixDB database) {
    return StreamBuilder(
      stream: database.assignedTaskDao
          .watchAllAssignedTasksByUserId(widget.loggedInUser.id),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? List();
        return ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (_, index) {
              return _buildTaskCard(
                  assignedTaskItem: tasks[index], database: database);
            },
          ),
        );
      },
    );
  }

  StreamBuilder<List<TaskWithBoard>> _buildTaskList(BuildContext context,
      TwixDB database) {
    return StreamBuilder(
        stream: watchAllTaskList(database),
        builder: (context, AsyncSnapshot<List<TaskWithBoard>> snapshot) {
          tasks = snapshot.data ?? List();
          return ScrollConfiguration(
            behavior: CustomScrollBehaviour(),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final taskItem = tasks[index];
                return _buildTaskCard(taskItem: taskItem, database: database);
              },
            ),
          );
        });
  }

  Widget _buildTaskCard({TaskWithBoard taskItem,
    AssignedTaskWithUser assignedTaskItem,
    TwixDB database}) {
    final TaskCard taskCard = TaskCard(
      task: taskItem != null ? taskItem : null,
      assignedTask: assignedTaskItem != null ? assignedTaskItem : null,
    );
    bool isDone =
    taskItem == null ? assignedTaskItem.task.isDone : taskItem.task.isDone;
    DismissDirection dismissDirection =
    isDone ? DismissDirection.endToStart : DismissDirection.horizontal;
    return Builder(
        builder: (context) =>
            Dismissible(
              key: ValueKey(taskCard.hashCode),
              direction: dismissDirection,
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
