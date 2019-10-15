import 'package:moor_flutter/moor_flutter.dart';

import 'package:uuid/uuid.dart';

class UserTable extends Table {
  TextColumn get id => text().withDefault(Variable(Uuid().v4()))();

  TextColumn get email => text()();

  TextColumn get password => text().nullable()();

  TextColumn get name => text()();

  TextColumn get token => text().nullable()();
}
