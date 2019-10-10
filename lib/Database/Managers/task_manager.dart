import 'package:sqflite/sqflite.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/Tables/task_table.dart';
import 'package:twix/Database/Managers/board_manager.dart';

class TaskManager {
  static final _tableName = 'Task';
  static final _tableBoard = BoardManager.getTableName;

  static final id = 'id';
  static final name = 'name';
  static final isDone = 'isDone';
  static final boardId = 'boardId';

  static final createSQL = "CREATE TABLE IF NOT EXISTS $_tableName ("
      "$id INTEGER PRIMARY KEY,"
      "$name TEXT NOT NULL,"
      "$isDone INTEGER NOT NULL,"
      "$boardId INTEGER NOT NULL,"
      "FOREIGN KEY ($boardId) REFERENCES $_tableBoard($id)"
      ")";

  static Future<int> insert(TaskTable taskTable) async {
    Database db = await DatabaseHelper.instance.database;
    return db.insert(_tableName, taskTable.toMap());
  }

  static Future<int> update(TaskTable taskTable) async {
    Database db = await DatabaseHelper.instance.database;
    return db.update(
        _tableName, taskTable.toMap(), where: '$id = ?', whereArgs: [id, ]
    );
  }

  static Future<List<Map<String, dynamic>>> boardTasks(int bId) async {
    Database db = await DatabaseHelper.instance.database;
    print(bId);
    return db.query(_tableName, where: '$boardId = ?', whereArgs: [bId]);
  }
}
