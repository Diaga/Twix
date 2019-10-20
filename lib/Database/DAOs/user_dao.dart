import 'package:moor_flutter/moor_flutter.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Database/Tables/user_table.dart';

part 'user_dao.g.dart';

@UseDao(tables: [UserTable])
class UserDao extends DatabaseAccessor<TwixDB> with _$UserDaoMixin {
  UserDao(TwixDB db) : super(db);

  Future<UserTableData> getLoggedInUser() =>
      (select(userTable)..where((user) => isNotNull(user.password)))
          .getSingle();

  Future<UserTableData> getUserById(String id) =>
      (select(userTable)..where((user) => user.id.equals(id))).getSingle();

  Stream<UserTableData> watchLoggedInUser() =>
      (select(userTable)..where((user) => isNotNull(user.password)))
          .watchSingle();

  Stream<UserTableData> watchUserByEmail(String email) =>
      (select(userTable)..where((user) => user.email.equals(email)))
          .watchSingle();

  Future<int> insertUser(Insertable<UserTableData> user) =>
      into(userTable).insert(user, orReplace: true);

  Future updateUser(Insertable<UserTableData> user) =>
      update(userTable).replace(user);

  Future deleteUser(Insertable<UserTableData> user) =>
      delete(userTable).delete(user);
}
