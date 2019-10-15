import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/board_table.dart';

part 'board_dao.g.dart';

@UseDao(tables: [BoardTable])
class BoardDao extends DatabaseAccessor<TwixDB> with _$BoardDaoMixin {
  BoardDao(TwixDB db) : super(db);

  Future<List<BoardTableData>> getAllBoards() => select(boardTable).get();

  Stream<List<BoardTableData>> watchAllBoards() => select(boardTable).watch();

  Future<int> insertBoard(Insertable<BoardTableData> board) =>
      into(boardTable).insert(board);

  Future updateBoard(Insertable<BoardTableData> board) =>
      update(boardTable).replace(board);

  Future deleteBoard(Insertable<BoardTableData> board) =>
      delete(boardTable).delete(board);
}
