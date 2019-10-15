import 'package:moor_flutter/moor_flutter.dart';

class GroupUserTable extends Table {
  TextColumn get groupId => text()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {groupId, userId};
}
