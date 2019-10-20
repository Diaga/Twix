import 'package:moor_flutter/moor_flutter.dart';

class GroupTable extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get name => text()();

  TextColumn get adminId =>
      text().customConstraint('NOT NULL REFERENCES user_table(id)')();

  BoolColumn get isSync =>
      boolean().withDefault(Constant(false))();
}