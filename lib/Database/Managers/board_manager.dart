class BoardManager {
  static final String _tableName = 'Board';

  static final createSQL = "CREATE TABLE IF NOT EXISTS $_tableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT NOT NULL,"
      "isPersonal INTEGER NOT NULL"
      ")";
}
