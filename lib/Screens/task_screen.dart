import 'package:flutter/material.dart';

import 'package:twix/Widgets/task/onswipe_container.dart';
import 'package:twix/Widgets/task/task_adder_sheet.dart';
import 'package:twix/Widgets/task/task_card.dart';

import 'package:twix/Database/Managers/task_manager.dart';
import 'package:twix/Database/Tables/task_table.dart';

class TaskScreen extends StatefulWidget {
  final int boardId;

  TaskScreen({@required this.boardId});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int boardId;
  List<TaskCard> tasks = [];

  @override
  void initState() {
    super.initState();
    boardId = this.widget.boardId;
    loadTasks();
  }

  void loadTasks() async {
    List<Map<String, dynamic>> taskMaps = await TaskManager.boardTasks(boardId);

    setState(() {
      List<TaskTable> taskTables =
          taskMaps.map((taskMap) => TaskTable.fromMap(taskMap)).toList();

      tasks = taskTables
          .map((taskTable) => TaskCard.fromObject(taskTable))
          .toList();
    });
  }

  void add() async {
    var result = await showModalBottomSheet(
      isScrollControlled: true,
      context: (context),
      builder: (context) {
        return TaskAdderSheet();
      },
    );
    if (result != null) {
      setState(() {
        TaskTable taskTable = TaskTable(name: result, boardId: boardId);
        TaskManager.insert(taskTable);

        // Call this to update screen
        loadTasks();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: add,
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
                        'Board Name',
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
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: ValueKey(tasks[index]),
                  background: OnSwipeContainer(
                    color: Colors.blue,
                    iconData: Icons.check,
                    alignment: Alignment.centerLeft,
                  ),
                  child: tasks[index],
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.startToEnd) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Completed"),
                          duration: Duration(milliseconds: 600),
                        ),
                      );
                    } else if (direction == DismissDirection.endToStart) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Deleted"),
                          duration: Duration(milliseconds: 600),
                        ),
                      );
                    }
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                  secondaryBackground: OnSwipeContainer(
                    color: Colors.red,
                    iconData: Icons.delete,
                    alignment: Alignment.centerRight,
                  ),
                );
              },
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
