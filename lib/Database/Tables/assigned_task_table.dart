import 'package:moor_flutter/moor_flutter.dart';

class AssignedTaskTable extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};

  // REQUIRED
  TextColumn get taskId => text()();

  // REQUIRED
  TextColumn get groupId => text()();

  // REQUIRED
  TextColumn get userId => text()();

  // REQUIRED
  BoolColumn get isDone => boolean()();

  BoolColumn get isSync => boolean().withDefault(Constant(false))();
}
