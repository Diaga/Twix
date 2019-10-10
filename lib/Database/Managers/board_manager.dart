import 'package:sqflite/sqflite.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/Tables/board_table.dart';

class BoardManager {
  static final String _tableName = 'Board';

  static String get getTableName => _tableName;

  static final String id = 'id';
  static final String name = 'name';
  static final String isPersonal = 'isPersonal';

  static final createSQL = "CREATE TABLE IF NOT EXISTS $_tableName ("
      "$id INTEGER PRIMARY KEY,"
      "$name TEXT NOT NULL,"
      "$isPersonal INTEGER NOT NULL"
      ")";

  static Future<int> insert(BoardTable boardTable) async {
    Database db = await DatabaseHelper.instance.database;
    return db.insert(_tableName, boardTable.toMap());
  }

  static Future<int> update(BoardTable boardTable) async {
    Database db = await DatabaseHelper.instance.database;
    return db.update(
        _tableName, boardTable.toMap(), where: '$id = ?', whereArgs: [id, ]
    );
  }

  static Future<List<Map<String, dynamic>>> boards() async {
    Database db = await DatabaseHelper.instance.database;
    return db.query(_tableName);
  }
}
