import 'package:moor_flutter/moor_flutter.dart';

class UserTable extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get email => text()();

  TextColumn get password => text().nullable()();

  TextColumn get name => text()();

  TextColumn get token => text().nullable()();
}
