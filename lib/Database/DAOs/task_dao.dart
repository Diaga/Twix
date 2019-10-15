import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/task_table.dart';

part 'task_dao.g.dart';

@UseDao(tables: [TaskTable])
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
}
