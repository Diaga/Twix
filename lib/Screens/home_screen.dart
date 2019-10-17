import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Screens/task_screen.dart';
import 'package:twix/Widgets/task/adder_sheet.dart';
import 'package:twix/Widgets/task/board_list.dart';
import 'package:twix/Widgets/task/custom_app_bar.dart';
import 'package:twix/Widgets/task/custom_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TwixDB database = Provider.of<TwixDB>(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            height: 80.0, color: ThemeData.light().scaffoldBackgroundColor),
        bottomNavigationBar: CustomBottomBar(
          listCallBack: () {
            _sheetDisplay(context, Icons.developer_board, 'Board', _insertBoard);
          },
          groupCallBack: () {
            _sheetDisplay(context, Icons.group_add, 'Group', _insertGroup);
          },
        ),
        body: ListView(
          children: <Widget>[
            BoardsList(
              iconData: Icons.wb_sunny,
              title: 'My Day',
              callBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskScreen(
                      action: 'My Day',
                    ),
                  ),
                );
              },
            ),
            BoardsList(
                iconData: Icons.person_outline,
                title: 'Assigned To Me',
                callBack: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskScreen()));
                }),
            BoardsList(
              iconData: Icons.playlist_add_check,
              title: 'My Tasks',
              callBack: () async {
                String myTasksBoardId =
                    (await database.boardDao.getMyTasksBoard()).id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskScreen(
                      boardId: myTasksBoardId,
                    ),
                  ),
                );
              },
            ),
            Divider(),
            _buildBoardList(context, database),
            Divider(),
            _buildGroupList(context, database)
          ],
        ),
      ),
    );
  }

  void _sheetDisplay(
      BuildContext context, IconData iconData, String text, Function callBack) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AdderSheet(
          iconData: iconData,
          text: text,
          callBack: callBack,
        );
      },
    );
  }

  _insertBoard(String boardName, TwixDB database) async {
    await database.boardDao.insertBoard(BoardTableCompanion(
        id: Value(Uuid().v4()),
        name: Value(boardName),
        createdAt: Value(DateTime.now())));
  }

  _insertGroup(String groupName, TwixDB database) async {
    await database.groupDao.insertGroup(GroupTableCompanion(
      id: Value(Uuid().v4()),
      name: Value(groupName),
    ));
  }

  StreamBuilder<List<BoardTableData>> _buildBoardList(
      BuildContext context, TwixDB database) {
    return StreamBuilder(
      stream: database.boardDao.watchAllBoards(),
      builder: (context, AsyncSnapshot<List<BoardTableData>> snapshot) {
        final boards = snapshot.data ?? List();
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: boards.length,
            itemBuilder: (_, index) {
              final boardItem = boards[index];
              return _buildBoardCard(context, boardItem);
            },);
      },
    );
  }

  Widget _buildBoardCard(BuildContext context, BoardTableData boardItem) {
    return BoardsList(
        iconData: Icons.developer_board,
        title: boardItem.name,
        callBack: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskScreen(
                        boardId: boardItem.id,
                      )));
        });
  }

  StreamBuilder<List<GroupTableData>> _buildGroupList(
      BuildContext context, TwixDB database) {
    return StreamBuilder(
      stream: database.groupDao.watchAllGroups(),
      builder: (context, AsyncSnapshot<List<GroupTableData>> snapshot) {
        final groups = snapshot.data ?? List();
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: groups.length,
            itemBuilder: (_, index) {
              final groupItem = groups[index];
              return _buildGroupCard(context, groupItem);
            });
      },
    );
  }

  Widget _buildGroupCard(BuildContext context, GroupTableData groupItem) {
    return BoardsList(
        iconData: Icons.group, title: groupItem.name, callBack: () {});
  }
}
