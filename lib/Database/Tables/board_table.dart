import 'package:moor_flutter/moor_flutter.dart';

class BoardTable extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get name => text()();

  BoolColumn get isMyTasks => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
}
