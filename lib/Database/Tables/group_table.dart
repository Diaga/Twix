import 'package:moor_flutter/moor_flutter.dart';

import 'package:uuid/uuid.dart';

class GroupTable extends Table {
  TextColumn get id => text().withDefault(Variable(Uuid().v4()))();

  TextColumn get name => text()();

  TextColumn get adminId =>
      text().customConstraint('NOT NULL REFERENCES user_table(id)')();
}