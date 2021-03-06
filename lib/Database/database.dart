import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/Tables/board_table.dart';
import 'package:twix/Database/Tables/group_table.dart';
import 'package:twix/Database/Tables/task_table.dart';
import 'package:twix/Database/Tables/user_table.dart';
import 'package:twix/Database/Tables/group_user_table.dart';
import 'package:twix/Database/Tables/assigned_task_table.dart';

import 'package:twix/Database/DAOs/board_dao.dart';
import 'package:twix/Database/DAOs/group_dao.dart';
import 'package:twix/Database/DAOs/task_dao.dart';
import 'package:twix/Database/DAOs/user_dao.dart';
import 'package:twix/Database/DAOs/group_user_dao.dart';
import 'package:twix/Database/DAOs/assigned_task_dao.dart';

import 'package:uuid/uuid.dart';

part 'database.g.dart';

@UseMoor(
    tables: [BoardTable, GroupTable, TaskTable, UserTable, GroupUserTable, AssignedTaskTable],
    daos: [BoardDao, GroupDao, TaskDao, UserDao, GroupUserDao, AssignedTaskDao])
class TwixDB extends _$TwixDB {
  TwixDB()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite3', logStatements: true)));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (migrator) {
        return migrator.createAllTables();
      },
      onUpgrade: (migrator, to, from) async {},
      beforeOpen: (details) async {
        if (details.wasCreated) {
          final id = Uuid().v4();
          await into(boardTable).insert(BoardTableCompanion(
              id: Value(id),
              name: Value('My Tasks'),
              isMyTasks: Value(true),
              createdAt: Value(DateTime.now())));
        }
      });
}
