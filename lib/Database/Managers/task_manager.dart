class TaskManager {
  static final _tableName = 'Task';

  static final createSQL = "CREATE TABLE IF NOT EXISTS $_tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT NOT NULL"
      ")";

  static insert(String name) {

  }
}
