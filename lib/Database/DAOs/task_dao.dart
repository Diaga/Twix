import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/task_table.dart';
import 'package:twix/Database/Tables/board_table.dart';

part 'task_dao.g.dart';

@UseDao(tables: [TaskTable, BoardTable])
class TaskDao extends DatabaseAccessor<TwixDB> with _$TaskDaoMixin {
  TaskDao(TwixDB db) : super(db);

  Future<int> insertTask(Insertable<TaskTableData> task) =>
      into(taskTable).insert(task);

  Future updateTask(Insertable<TaskTableData> task) =>
      update(taskTable).replace(task);

  Future deleteTask(Insertable<TaskTableData> task) =>
      delete(taskTable).delete(task);

  Stream<List<TaskTableData>> watchAllTasksByBoardId(String boardId) =>
      (select(taskTable)..where((row) => row.boardId.equals(boardId))).watch();

  Stream<List<TaskWithBoard>> watchAllMyDayTasks() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return (select(taskTable)..where((row) => row.myDayDate.equals(today)))
        .join([
          innerJoin(taskTable, taskTable.boardId.equalsExp(boardTable.id)),
        ])
        .watch()
        .map((rows) => rows
            .map((row) => TaskWithBoard(
                task: row.readTable(taskTable),
                board: row.readTable(boardTable)))
            .toList());
  }
}

class TaskWithBoard {
  final TaskTableData task;
  final BoardTableData board;

  TaskWithBoard({this.task, this.board});
}
