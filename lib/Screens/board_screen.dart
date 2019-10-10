import 'package:flutter/material.dart';

import 'package:twix/Widgets/board/board.dart';
import 'package:twix/Palette/palette.dart';
import 'package:twix/Database/Managers/board_manager.dart';
import 'package:twix/Database/Tables/board_table.dart';

import 'create_board.dart';

class BoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<Board> boards = [];

  @override
  void initState() {
    super.initState();
    loadBoards();
  }

  void loadBoards() async {
    List<Map<String, dynamic>> boardMaps = await BoardManager.boards();

    setState(() {
      List<BoardTable> boardTables =
          boardMaps.map((boardMap) => BoardTable.fromMap(boardMap)).toList();
      boards = boardTables
          .map((boardTable) => Board.fromObject(boardTable))
          .toList();
    });
  }
  void add() async{
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateBoard(),
      ),
    );
   if (result!=null){
     setState(() {
       BoardManager.insert(result);
       loadBoards();
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boards'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Palette.primaryColor,
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
