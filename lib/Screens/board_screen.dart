import 'package:flutter/material.dart';

import 'package:twix/Widgets/board/board.dart';

import 'package:twix/Database/Managers/board_manager.dart';
import 'package:twix/Database/Tables/board_table.dart';

class BoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<Board> boards = [];

  _BoardScreenState() {
    initial();
    loadBoards();
  }

  void initial() async {
    List<Map<String, dynamic>> boardMaps = await BoardManager.boards();
    if (boardMaps.length == 0) {
      BoardTable boardTable1 = BoardTable(name: 'Board 1');
      BoardTable boardTable2 = BoardTable(name: 'Board 2');

      BoardManager.insert(boardTable1);
      BoardManager.insert(boardTable2);
    }
  }

  void loadBoards() async {
    List<Map<String, dynamic>> boardMaps = await BoardManager.boards();

    List<BoardTable> boardTables =
        boardMaps.map((boardMap) => BoardTable.fromMap(boardMap)).toList();
    boards =
        boardTables.map((boardTable) => Board.fromObject(boardTable)).toList();
    setState(() {});
  }

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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return boards[index];
                },
                itemCount: boards.length,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Group Boards'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 120,
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
