import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

class TaskTable extends Table {
  TextColumn get id => text().withDefault(Variable(Uuid().v4()))();

  // REQUIRED
  TextColumn get name => text()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  DateTimeColumn get remindMe => dateTime().nullable()();

  DateTimeColumn get myDayDate => dateTime().nullable()();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  // REQUIRED
  TextColumn get boardId => text()
      .nullable()
      .customConstraint('NOT NULL REFERENCES board_table(id)')();

  TextColumn get assignedTo => text()
      .nullable()
      .customConstraint('NULLABLE REFERENCES group_table(id)')();
}
