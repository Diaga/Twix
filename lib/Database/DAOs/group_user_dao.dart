import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/group_table.dart';
import 'package:twix/Database/Tables/user_table.dart';
import 'package:twix/Database/Tables/group_user_table.dart';

part 'group_user_dao.g.dart';

@UseDao(tables: [UserTable, GroupTable, GroupUserTable])
class GroupUserDao extends DatabaseAccessor<TwixDB> with _$GroupUserDaoMixin {
  GroupUserDao(TwixDB db) : super(db);

  Future<int> insertGroupUser(Insertable<GroupUserTableData> groupUser) =>
      into(groupUserTable).insert(groupUser, orReplace: true);

  Future deleteGroupUser(Insertable<GroupUserTableData> groupUser) =>
      delete(groupUserTable).delete(groupUser);

  Future<GroupWithUser> getGroupUserByGroupUserId(
          String userId, String groupId) =>
      (select(groupUserTable)
            ..where((row) => row.groupId.equals(groupId))
            ..where((row) => row.userId.equals(userId)))
          .join([
            innerJoin(
                groupTable, groupUserTable.groupId.equalsExp(groupTable.id)),
            innerJoin(userTable, groupUserTable.userId.equalsExp(userTable.id))
          ])
          .map((row) => GroupWithUser(
              group: row.readTable(groupTable), user: row.readTable(userTable)))
          .getSingle();

  Stream<List<GroupWithUser>> watchGroupUsersByGroupId(String groupId) =>
      (select(groupUserTable)..where((row) => row.groupId.equals(groupId)))
          .join([
            innerJoin(
                groupTable, groupUserTable.groupId.equalsExp(groupTable.id)),
            innerJoin(userTable, groupUserTable.userId.equalsExp(userTable.id))
          ])
          .watch()
          .map((rows) => rows
              .map((row) => GroupWithUser(
                  group: row.readTable(groupTable),
                  user: row.readTable(userTable)))
              .toList());
}

class GroupWithUser {
  final GroupTableData group;
  final UserTableData user;

  GroupWithUser({this.group, this.user});
}
