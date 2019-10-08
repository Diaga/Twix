import 'package:flutter/material.dart';
import 'package:twix/Widgets/board/board.dart';

class BoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boards'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personal Boards'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Board(
                    heading: 'Board 1',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                  Board(
                    heading: 'Board 2',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                  Board(
                    heading: 'Board 3',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Group Boards'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Board(
                    heading: 'Board 1',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                  Board(
                    heading: 'Board 2',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                  Board(
                    heading: 'Board 3',
                    doneTasks: 1,
                    totalTasks: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
