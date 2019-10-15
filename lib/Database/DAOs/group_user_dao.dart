import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/group_user_table.dart';

part 'group_user_dao.g.dart';

@UseDao(tables: [GroupUserTable])
class GroupUserDao extends DatabaseAccessor<TwixDB> with _$GroupUserDaoMixin {
  GroupUserDao(TwixDB db) : super(db);

}
