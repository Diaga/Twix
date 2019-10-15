import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

class TaskTable extends Table {
  TextColumn get id => text().withDefault(Variable(Uuid().v4()))();

  TextColumn get name => text()();

  TextColumn get notes => text()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  DateTimeColumn get remindMe => dateTime().nullable()();

  TextColumn get boardId =>
      text().customConstraint('NOT NULL REFERENCES board_table(id)')();
}
