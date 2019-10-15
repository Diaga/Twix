import 'package:moor_flutter/moor_flutter.dart';

import 'package:uuid/uuid.dart';

class BoardTable extends Table {
  TextColumn get id => text().withDefault(Variable(Uuid().v4()))();

  TextColumn get name => text()();
}
