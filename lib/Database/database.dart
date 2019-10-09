import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:twix/Database/Managers/board_manager.dart';
import 'package:twix/Database/Managers/task_manager.dart';


class DatabaseHelper {
  static final _databaseName = 'twix.db';
  static final _databaseVersion = 1;

  // Singleton Class
  DatabaseHelper._privateConstruction();
  static final DatabaseHelper instance = DatabaseHelper._privateConstruction();

  // Global single db reference
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // Lazily initialize db
    _database = await _initDatabase();
    return _database;
  }

  // Initialize db
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  // SQL Code to create tables
  Future _onCreate(Database db, int version) async {
    // Create board table
    await db.execute(BoardManager.createSQL);
    await db.execute(TaskManager.createSQL);
  }
}
