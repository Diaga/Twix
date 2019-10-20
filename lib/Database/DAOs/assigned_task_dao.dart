import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/Tables/assigned_task_table.dart';
import 'package:twix/Database/Tables/user_table.dart';
import 'package:twix/Database/Tables/task_table.dart';

part 'assigned_task_dao.g.dart';

@UseDao(tables: [AssignedTaskTable, UserTable, TaskTable])
class AssignedTaskDao extends DatabaseAccessor<TwixDB>
    with _$AssignedTaskDaoMixin {
  AssignedTaskDao(TwixDB db) : super(db);

  Future insertAssignedTask(Insertable<AssignedTaskTableData> assignedTask) =>
      into(assignedTaskTable).insert(assignedTask, orReplace: true);

  Future deleteAssignedTask(Insertable<AssignedTaskTableData> assignedTask) =>
      delete(assignedTaskTable).delete(assignedTask);

  Future<AssignedTaskTableData> getAssignedTaskByTaskId(String taskId) =>
      (select(assignedTaskTable)..where((row) => row.taskId.equals(taskId)))
          .getSingle();

  Stream<List<AssignedTaskWithUser>> watchAllAssignedTasksByUserId(
          String userId) =>
      (select(assignedTaskTable)
            ..where((row) => row.userId.equals(userId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.isDone, mode: OrderingMode.desc),
            ]))
          .join([
            innerJoin(
                userTable, assignedTaskTable.userId.equalsExp(userTable.id)),
            innerJoin(
                taskTable, assignedTaskTable.taskId.equalsExp(taskTable.id))
          ])
          .watch()
          .map((rows) => rows
              .map((row) => AssignedTaskWithUser(
                  user: row.readTable(userTable),
                  task: row.readTable(taskTable),
                  assignedTask: row.readTable(assignedTaskTable)))
              .toList());

  Stream<List<AssignedTaskWithUser>> watchDoneAssignedTasksByUserId(
          String userId) =>
      (select(assignedTaskTable)
            ..where((row) => row.userId.equals(userId))
            ..where((row) => row.isDone.equals(true)))
          .join([
            innerJoin(
                userTable, assignedTaskTable.userId.equalsExp(userTable.id)),
            innerJoin(
                taskTable, assignedTaskTable.taskId.equalsExp(taskTable.id))
          ])
          .watch()
          .map((rows) => rows
              .map((row) => AssignedTaskWithUser(
                  user: row.readTable(userTable),
                  task: row.readTable(taskTable),
                  assignedTask: row.readTable(assignedTaskTable)))
              .toList());

  Future<List<AssignedTaskWithUser>> getAllAssignedTasksByUserId(
          String userId) =>
      (select(assignedTaskTable)..where((row) => row.userId.equals(userId)))
          .join([
            innerJoin(
                userTable, assignedTaskTable.userId.equalsExp(userTable.id)),
            innerJoin(
                taskTable, assignedTaskTable.taskId.equalsExp(taskTable.id))
          ])
          .map(((row) => AssignedTaskWithUser(
              user: row.readTable(userTable),
              task: row.readTable(taskTable),
              assignedTask: row.readTable(assignedTaskTable))))
          .get();

  Future<List<AssignedTaskWithUser>> getDoneAssignedTasksByUserId(
          String userId) =>
      (select(assignedTaskTable)
            ..where((row) => row.userId.equals(userId))
            ..where((row) => row.isDone.equals(true)))
          .join([
            innerJoin(
                userTable, assignedTaskTable.userId.equalsExp(userTable.id)),
            innerJoin(
                taskTable, assignedTaskTable.taskId.equalsExp(taskTable.id))
          ])
          .map(((row) => AssignedTaskWithUser(
              user: row.readTable(userTable),
              task: row.readTable(taskTable),
              assignedTask: row.readTable(assignedTaskTable))))
          .get();
}

class AssignedTaskWithUser {
  final UserTableData user;
  final TaskTableData task;
  final AssignedTaskTableData assignedTask;

  AssignedTaskWithUser({this.user, this.task, this.assignedTask});
}
