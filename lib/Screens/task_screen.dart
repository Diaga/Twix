import 'package:flutter/material.dart';

import 'package:twix/Widgets/task/onswipe_container.dart';
import 'package:twix/Widgets/task/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final tasks = List<Task>();

  void addTask() {
    setState(() {
      tasks.add(Task());
    });
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
        onPressed: addTask,
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
            child: ScrollConfiguration(
              behavior: CustomBehavior(),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: ValueKey(index),
                    background: OnSwipeContainer(color: Colors.blue),
                    child: tasks[index],
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Completed"),
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      } else if (direction == DismissDirection.endToStart) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Deleted"),
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      }
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    secondaryBackground: OnSwipeContainer(color: Colors.red,),
                  );
                },
                itemCount: tasks.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}



class CustomBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
