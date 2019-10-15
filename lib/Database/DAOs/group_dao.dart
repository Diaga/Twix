import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/group_table.dart';

part 'group_dao.g.dart';

@UseDao(tables: [GroupTable])
class GroupDao extends DatabaseAccessor<TwixDB> with _$GroupDaoMixin {
  GroupDao(TwixDB db) : super(db);

  Future<int> insertGroup(Insertable<GroupTableData> group) =>
      into(groupTable).insert(group);

  Future updateGroup(Insertable<GroupTableData> group) =>
      update(groupTable).replace(group);

  Future deleteGroup(Insertable<GroupTableData> group) =>
      delete(groupTable).delete(group);
}
