import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/Tables/assigned_task_table.dart';

part 'assigned_task_dao.g.dart';

@UseDao(tables: [AssignedTaskTable])
class AssignedTaskDao extends DatabaseAccessor<TwixDB> with _$AssignedTaskDaoMixin {
  AssignedTaskDao(TwixDB db) : super(db);

}
