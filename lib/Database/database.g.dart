// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BoardTableData extends DataClass implements Insertable<BoardTableData> {
  final String id;
  final String name;
  final bool isMyTasks;
  final DateTime createdAt;
  BoardTableData(
      {@required this.id,
      @required this.name,
      @required this.isMyTasks,
      @required this.createdAt});
  factory BoardTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return BoardTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      isMyTasks: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_my_tasks']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  factory BoardTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return BoardTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isMyTasks: serializer.fromJson<bool>(json['isMyTasks']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isMyTasks': serializer.toJson<bool>(isMyTasks),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  @override
  BoardTableCompanion createCompanion(bool nullToAbsent) {
    return BoardTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      isMyTasks: isMyTasks == null && nullToAbsent
          ? const Value.absent()
          : Value(isMyTasks),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  BoardTableData copyWith(
          {String id, String name, bool isMyTasks, DateTime createdAt}) =>
      BoardTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        isMyTasks: isMyTasks ?? this.isMyTasks,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('BoardTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isMyTasks: $isMyTasks, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(isMyTasks.hashCode, createdAt.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is BoardTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isMyTasks == this.isMyTasks &&
          other.createdAt == this.createdAt);
}

class BoardTableCompanion extends UpdateCompanion<BoardTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isMyTasks;
  final Value<DateTime> createdAt;
  const BoardTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isMyTasks = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BoardTableCompanion.insert({
    @required String id,
    @required String name,
    this.isMyTasks = const Value.absent(),
    @required DateTime createdAt,
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  BoardTableCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<bool> isMyTasks,
      Value<DateTime> createdAt}) {
    return BoardTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isMyTasks: isMyTasks ?? this.isMyTasks,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class $BoardTableTable extends BoardTable
    with TableInfo<$BoardTableTable, BoardTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BoardTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isMyTasksMeta = const VerificationMeta('isMyTasks');
  GeneratedBoolColumn _isMyTasks;
  @override
  GeneratedBoolColumn get isMyTasks => _isMyTasks ??= _constructIsMyTasks();
  GeneratedBoolColumn _constructIsMyTasks() {
    return GeneratedBoolColumn('is_my_tasks', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, isMyTasks, createdAt];
  @override
  $BoardTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'board_table';
  @override
  final String actualTableName = 'board_table';
  @override
  VerificationContext validateIntegrity(BoardTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.isMyTasks.present) {
      context.handle(_isMyTasksMeta,
          isMyTasks.isAcceptableValue(d.isMyTasks.value, _isMyTasksMeta));
    } else if (isMyTasks.isRequired && isInserting) {
      context.missing(_isMyTasksMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BoardTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BoardTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BoardTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.isMyTasks.present) {
      map['is_my_tasks'] = Variable<bool, BoolType>(d.isMyTasks.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    return map;
  }

  @override
  $BoardTableTable createAlias(String alias) {
    return $BoardTableTable(_db, alias);
  }
}

class GroupTableData extends DataClass implements Insertable<GroupTableData> {
  final String id;
  final String name;
  final String adminId;
  final bool isSync;
  GroupTableData(
      {@required this.id,
      @required this.name,
      @required this.adminId,
      @required this.isSync});
  factory GroupTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return GroupTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      adminId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}admin_id']),
      isSync:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_sync']),
    );
  }
  factory GroupTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return GroupTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      adminId: serializer.fromJson<String>(json['adminId']),
      isSync: serializer.fromJson<bool>(json['isSync']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'adminId': serializer.toJson<String>(adminId),
      'isSync': serializer.toJson<bool>(isSync),
    };
  }

  @override
  GroupTableCompanion createCompanion(bool nullToAbsent) {
    return GroupTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      adminId: adminId == null && nullToAbsent
          ? const Value.absent()
          : Value(adminId),
      isSync:
          isSync == null && nullToAbsent ? const Value.absent() : Value(isSync),
    );
  }

  GroupTableData copyWith(
          {String id, String name, String adminId, bool isSync}) =>
      GroupTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        adminId: adminId ?? this.adminId,
        isSync: isSync ?? this.isSync,
      );
  @override
  String toString() {
    return (StringBuffer('GroupTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('adminId: $adminId, ')
          ..write('isSync: $isSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(adminId.hashCode, isSync.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is GroupTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.adminId == this.adminId &&
          other.isSync == this.isSync);
}

class GroupTableCompanion extends UpdateCompanion<GroupTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> adminId;
  final Value<bool> isSync;
  const GroupTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.adminId = const Value.absent(),
    this.isSync = const Value.absent(),
  });
  GroupTableCompanion.insert({
    @required String id,
    @required String name,
    @required String adminId,
    this.isSync = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        adminId = Value(adminId);
  GroupTableCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> adminId,
      Value<bool> isSync}) {
    return GroupTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      adminId: adminId ?? this.adminId,
      isSync: isSync ?? this.isSync,
    );
  }
}

class $GroupTableTable extends GroupTable
    with TableInfo<$GroupTableTable, GroupTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $GroupTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _adminIdMeta = const VerificationMeta('adminId');
  GeneratedTextColumn _adminId;
  @override
  GeneratedTextColumn get adminId => _adminId ??= _constructAdminId();
  GeneratedTextColumn _constructAdminId() {
    return GeneratedTextColumn('admin_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES user_table(id)');
  }

  final VerificationMeta _isSyncMeta = const VerificationMeta('isSync');
  GeneratedBoolColumn _isSync;
  @override
  GeneratedBoolColumn get isSync => _isSync ??= _constructIsSync();
  GeneratedBoolColumn _constructIsSync() {
    return GeneratedBoolColumn('is_sync', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, adminId, isSync];
  @override
  $GroupTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'group_table';
  @override
  final String actualTableName = 'group_table';
  @override
  VerificationContext validateIntegrity(GroupTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.adminId.present) {
      context.handle(_adminIdMeta,
          adminId.isAcceptableValue(d.adminId.value, _adminIdMeta));
    } else if (adminId.isRequired && isInserting) {
      context.missing(_adminIdMeta);
    }
    if (d.isSync.present) {
      context.handle(
          _isSyncMeta, isSync.isAcceptableValue(d.isSync.value, _isSyncMeta));
    } else if (isSync.isRequired && isInserting) {
      context.missing(_isSyncMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GroupTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(GroupTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.adminId.present) {
      map['admin_id'] = Variable<String, StringType>(d.adminId.value);
    }
    if (d.isSync.present) {
      map['is_sync'] = Variable<bool, BoolType>(d.isSync.value);
    }
    return map;
  }

  @override
  $GroupTableTable createAlias(String alias) {
    return $GroupTableTable(_db, alias);
  }
}

class TaskTableData extends DataClass implements Insertable<TaskTableData> {
  final String id;
  final String name;
  final String notes;
  final DateTime dueDate;
  final DateTime remindMe;
  final DateTime myDayDate;
  final bool isDone;
  final DateTime createdAt;
  final String boardId;
  final String assignedTo;
  final bool isSync;
  TaskTableData(
      {@required this.id,
      @required this.name,
      this.notes,
      this.dueDate,
      this.remindMe,
      this.myDayDate,
      @required this.isDone,
      @required this.createdAt,
      @required this.boardId,
      this.assignedTo,
      @required this.isSync});
  factory TaskTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return TaskTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      remindMe: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}remind_me']),
      myDayDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}my_day_date']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      boardId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}board_id']),
      assignedTo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}assigned_to']),
      isSync:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_sync']),
    );
  }
  factory TaskTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TaskTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String>(json['notes']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      remindMe: serializer.fromJson<DateTime>(json['remindMe']),
      myDayDate: serializer.fromJson<DateTime>(json['myDayDate']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      boardId: serializer.fromJson<String>(json['boardId']),
      assignedTo: serializer.fromJson<String>(json['assignedTo']),
      isSync: serializer.fromJson<bool>(json['isSync']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String>(notes),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'remindMe': serializer.toJson<DateTime>(remindMe),
      'myDayDate': serializer.toJson<DateTime>(myDayDate),
      'isDone': serializer.toJson<bool>(isDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'boardId': serializer.toJson<String>(boardId),
      'assignedTo': serializer.toJson<String>(assignedTo),
      'isSync': serializer.toJson<bool>(isSync),
    };
  }

  @override
  TaskTableCompanion createCompanion(bool nullToAbsent) {
    return TaskTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      remindMe: remindMe == null && nullToAbsent
          ? const Value.absent()
          : Value(remindMe),
      myDayDate: myDayDate == null && nullToAbsent
          ? const Value.absent()
          : Value(myDayDate),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      boardId: boardId == null && nullToAbsent
          ? const Value.absent()
          : Value(boardId),
      assignedTo: assignedTo == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedTo),
      isSync:
          isSync == null && nullToAbsent ? const Value.absent() : Value(isSync),
    );
  }

  TaskTableData copyWith(
          {String id,
          String name,
          String notes,
          DateTime dueDate,
          DateTime remindMe,
          DateTime myDayDate,
          bool isDone,
          DateTime createdAt,
          String boardId,
          String assignedTo,
          bool isSync}) =>
      TaskTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        notes: notes ?? this.notes,
        dueDate: dueDate ?? this.dueDate,
        remindMe: remindMe ?? this.remindMe,
        myDayDate: myDayDate ?? this.myDayDate,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
        boardId: boardId ?? this.boardId,
        assignedTo: assignedTo ?? this.assignedTo,
        isSync: isSync ?? this.isSync,
      );
  @override
  String toString() {
    return (StringBuffer('TaskTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('dueDate: $dueDate, ')
          ..write('remindMe: $remindMe, ')
          ..write('myDayDate: $myDayDate, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('boardId: $boardId, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('isSync: $isSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              notes.hashCode,
              $mrjc(
                  dueDate.hashCode,
                  $mrjc(
                      remindMe.hashCode,
                      $mrjc(
                          myDayDate.hashCode,
                          $mrjc(
                              isDone.hashCode,
                              $mrjc(
                                  createdAt.hashCode,
                                  $mrjc(
                                      boardId.hashCode,
                                      $mrjc(assignedTo.hashCode,
                                          isSync.hashCode)))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TaskTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.dueDate == this.dueDate &&
          other.remindMe == this.remindMe &&
          other.myDayDate == this.myDayDate &&
          other.isDone == this.isDone &&
          other.createdAt == this.createdAt &&
          other.boardId == this.boardId &&
          other.assignedTo == this.assignedTo &&
          other.isSync == this.isSync);
}

class TaskTableCompanion extends UpdateCompanion<TaskTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> notes;
  final Value<DateTime> dueDate;
  final Value<DateTime> remindMe;
  final Value<DateTime> myDayDate;
  final Value<bool> isDone;
  final Value<DateTime> createdAt;
  final Value<String> boardId;
  final Value<String> assignedTo;
  final Value<bool> isSync;
  const TaskTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.remindMe = const Value.absent(),
    this.myDayDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.boardId = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.isSync = const Value.absent(),
  });
  TaskTableCompanion.insert({
    @required String id,
    @required String name,
    this.notes = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.remindMe = const Value.absent(),
    this.myDayDate = const Value.absent(),
    this.isDone = const Value.absent(),
    @required DateTime createdAt,
    @required String boardId,
    this.assignedTo = const Value.absent(),
    this.isSync = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        boardId = Value(boardId);
  TaskTableCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> notes,
      Value<DateTime> dueDate,
      Value<DateTime> remindMe,
      Value<DateTime> myDayDate,
      Value<bool> isDone,
      Value<DateTime> createdAt,
      Value<String> boardId,
      Value<String> assignedTo,
      Value<bool> isSync}) {
    return TaskTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      dueDate: dueDate ?? this.dueDate,
      remindMe: remindMe ?? this.remindMe,
      myDayDate: myDayDate ?? this.myDayDate,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      boardId: boardId ?? this.boardId,
      assignedTo: assignedTo ?? this.assignedTo,
      isSync: isSync ?? this.isSync,
    );
  }
}

class $TaskTableTable extends TaskTable
    with TableInfo<$TaskTableTable, TaskTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaskTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _remindMeMeta = const VerificationMeta('remindMe');
  GeneratedDateTimeColumn _remindMe;
  @override
  GeneratedDateTimeColumn get remindMe => _remindMe ??= _constructRemindMe();
  GeneratedDateTimeColumn _constructRemindMe() {
    return GeneratedDateTimeColumn(
      'remind_me',
      $tableName,
      true,
    );
  }

  final VerificationMeta _myDayDateMeta = const VerificationMeta('myDayDate');
  GeneratedDateTimeColumn _myDayDate;
  @override
  GeneratedDateTimeColumn get myDayDate => _myDayDate ??= _constructMyDayDate();
  GeneratedDateTimeColumn _constructMyDayDate() {
    return GeneratedDateTimeColumn(
      'my_day_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _boardIdMeta = const VerificationMeta('boardId');
  GeneratedTextColumn _boardId;
  @override
  GeneratedTextColumn get boardId => _boardId ??= _constructBoardId();
  GeneratedTextColumn _constructBoardId() {
    return GeneratedTextColumn('board_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES board_table(id)');
  }

  final VerificationMeta _assignedToMeta = const VerificationMeta('assignedTo');
  GeneratedTextColumn _assignedTo;
  @override
  GeneratedTextColumn get assignedTo => _assignedTo ??= _constructAssignedTo();
  GeneratedTextColumn _constructAssignedTo() {
    return GeneratedTextColumn('assigned_to', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES group_table(id)');
  }

  final VerificationMeta _isSyncMeta = const VerificationMeta('isSync');
  GeneratedBoolColumn _isSync;
  @override
  GeneratedBoolColumn get isSync => _isSync ??= _constructIsSync();
  GeneratedBoolColumn _constructIsSync() {
    return GeneratedBoolColumn('is_sync', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        notes,
        dueDate,
        remindMe,
        myDayDate,
        isDone,
        createdAt,
        boardId,
        assignedTo,
        isSync
      ];
  @override
  $TaskTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'task_table';
  @override
  final String actualTableName = 'task_table';
  @override
  VerificationContext validateIntegrity(TaskTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.notes.present) {
      context.handle(
          _notesMeta, notes.isAcceptableValue(d.notes.value, _notesMeta));
    } else if (notes.isRequired && isInserting) {
      context.missing(_notesMeta);
    }
    if (d.dueDate.present) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableValue(d.dueDate.value, _dueDateMeta));
    } else if (dueDate.isRequired && isInserting) {
      context.missing(_dueDateMeta);
    }
    if (d.remindMe.present) {
      context.handle(_remindMeMeta,
          remindMe.isAcceptableValue(d.remindMe.value, _remindMeMeta));
    } else if (remindMe.isRequired && isInserting) {
      context.missing(_remindMeMeta);
    }
    if (d.myDayDate.present) {
      context.handle(_myDayDateMeta,
          myDayDate.isAcceptableValue(d.myDayDate.value, _myDayDateMeta));
    } else if (myDayDate.isRequired && isInserting) {
      context.missing(_myDayDateMeta);
    }
    if (d.isDone.present) {
      context.handle(
          _isDoneMeta, isDone.isAcceptableValue(d.isDone.value, _isDoneMeta));
    } else if (isDone.isRequired && isInserting) {
      context.missing(_isDoneMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (createdAt.isRequired && isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.boardId.present) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableValue(d.boardId.value, _boardIdMeta));
    } else if (boardId.isRequired && isInserting) {
      context.missing(_boardIdMeta);
    }
    if (d.assignedTo.present) {
      context.handle(_assignedToMeta,
          assignedTo.isAcceptableValue(d.assignedTo.value, _assignedToMeta));
    } else if (assignedTo.isRequired && isInserting) {
      context.missing(_assignedToMeta);
    }
    if (d.isSync.present) {
      context.handle(
          _isSyncMeta, isSync.isAcceptableValue(d.isSync.value, _isSyncMeta));
    } else if (isSync.isRequired && isInserting) {
      context.missing(_isSyncMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaskTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.notes.present) {
      map['notes'] = Variable<String, StringType>(d.notes.value);
    }
    if (d.dueDate.present) {
      map['due_date'] = Variable<DateTime, DateTimeType>(d.dueDate.value);
    }
    if (d.remindMe.present) {
      map['remind_me'] = Variable<DateTime, DateTimeType>(d.remindMe.value);
    }
    if (d.myDayDate.present) {
      map['my_day_date'] = Variable<DateTime, DateTimeType>(d.myDayDate.value);
    }
    if (d.isDone.present) {
      map['is_done'] = Variable<bool, BoolType>(d.isDone.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.boardId.present) {
      map['board_id'] = Variable<String, StringType>(d.boardId.value);
    }
    if (d.assignedTo.present) {
      map['assigned_to'] = Variable<String, StringType>(d.assignedTo.value);
    }
    if (d.isSync.present) {
      map['is_sync'] = Variable<bool, BoolType>(d.isSync.value);
    }
    return map;
  }

  @override
  $TaskTableTable createAlias(String alias) {
    return $TaskTableTable(_db, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final String id;
  final String email;
  final String password;
  final String name;
  final String token;
  UserTableData(
      {@required this.id,
      @required this.email,
      this.password,
      @required this.name,
      this.token});
  factory UserTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return UserTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      token:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}token']),
    );
  }
  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return UserTableData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      name: serializer.fromJson<String>(json['name']),
      token: serializer.fromJson<String>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'name': serializer.toJson<String>(name),
      'token': serializer.toJson<String>(token),
    };
  }

  @override
  UserTableCompanion createCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
    );
  }

  UserTableData copyWith(
          {String id,
          String email,
          String password,
          String name,
          String token}) =>
      UserTableData(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        token: token ?? this.token,
      );
  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(email.hashCode,
          $mrjc(password.hashCode, $mrjc(name.hashCode, token.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password &&
          other.name == this.name &&
          other.token == this.token);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> password;
  final Value<String> name;
  final Value<String> token;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.name = const Value.absent(),
    this.token = const Value.absent(),
  });
  UserTableCompanion.insert({
    @required String id,
    @required String email,
    this.password = const Value.absent(),
    @required String name,
    this.token = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        name = Value(name);
  UserTableCompanion copyWith(
      {Value<String> id,
      Value<String> email,
      Value<String> password,
      Value<String> name,
      Value<String> token}) {
    return UserTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  GeneratedTextColumn _token;
  @override
  GeneratedTextColumn get token => _token ??= _constructToken();
  GeneratedTextColumn _constructToken() {
    return GeneratedTextColumn(
      'token',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, email, password, name, token];
  @override
  $UserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_table';
  @override
  final String actualTableName = 'user_table';
  @override
  VerificationContext validateIntegrity(UserTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (email.isRequired && isInserting) {
      context.missing(_emailMeta);
    }
    if (d.password.present) {
      context.handle(_passwordMeta,
          password.isAcceptableValue(d.password.value, _passwordMeta));
    } else if (password.isRequired && isInserting) {
      context.missing(_passwordMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.token.present) {
      context.handle(
          _tokenMeta, token.isAcceptableValue(d.token.value, _tokenMeta));
    } else if (token.isRequired && isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UserTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.password.present) {
      map['password'] = Variable<String, StringType>(d.password.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.token.present) {
      map['token'] = Variable<String, StringType>(d.token.value);
    }
    return map;
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

class GroupUserTableData extends DataClass
    implements Insertable<GroupUserTableData> {
  final String groupId;
  final String userId;
  GroupUserTableData({@required this.groupId, @required this.userId});
  factory GroupUserTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return GroupUserTableData(
      groupId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}group_id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
    );
  }
  factory GroupUserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return GroupUserTableData(
      groupId: serializer.fromJson<String>(json['groupId']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'groupId': serializer.toJson<String>(groupId),
      'userId': serializer.toJson<String>(userId),
    };
  }

  @override
  GroupUserTableCompanion createCompanion(bool nullToAbsent) {
    return GroupUserTableCompanion(
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  GroupUserTableData copyWith({String groupId, String userId}) =>
      GroupUserTableData(
        groupId: groupId ?? this.groupId,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('GroupUserTableData(')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(groupId.hashCode, userId.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is GroupUserTableData &&
          other.groupId == this.groupId &&
          other.userId == this.userId);
}

class GroupUserTableCompanion extends UpdateCompanion<GroupUserTableData> {
  final Value<String> groupId;
  final Value<String> userId;
  const GroupUserTableCompanion({
    this.groupId = const Value.absent(),
    this.userId = const Value.absent(),
  });
  GroupUserTableCompanion.insert({
    @required String groupId,
    @required String userId,
  })  : groupId = Value(groupId),
        userId = Value(userId);
  GroupUserTableCompanion copyWith(
      {Value<String> groupId, Value<String> userId}) {
    return GroupUserTableCompanion(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
    );
  }
}

class $GroupUserTableTable extends GroupUserTable
    with TableInfo<$GroupUserTableTable, GroupUserTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $GroupUserTableTable(this._db, [this._alias]);
  final VerificationMeta _groupIdMeta = const VerificationMeta('groupId');
  GeneratedTextColumn _groupId;
  @override
  GeneratedTextColumn get groupId => _groupId ??= _constructGroupId();
  GeneratedTextColumn _constructGroupId() {
    return GeneratedTextColumn(
      'group_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [groupId, userId];
  @override
  $GroupUserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'group_user_table';
  @override
  final String actualTableName = 'group_user_table';
  @override
  VerificationContext validateIntegrity(GroupUserTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.groupId.present) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableValue(d.groupId.value, _groupIdMeta));
    } else if (groupId.isRequired && isInserting) {
      context.missing(_groupIdMeta);
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (userId.isRequired && isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, userId};
  @override
  GroupUserTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GroupUserTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(GroupUserTableCompanion d) {
    final map = <String, Variable>{};
    if (d.groupId.present) {
      map['group_id'] = Variable<String, StringType>(d.groupId.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    return map;
  }

  @override
  $GroupUserTableTable createAlias(String alias) {
    return $GroupUserTableTable(_db, alias);
  }
}

class AssignedTaskTableData extends DataClass
    implements Insertable<AssignedTaskTableData> {
  final String id;
  final String taskId;
  final String groupId;
  final String userId;
  final bool isDone;
  final bool isSync;
  AssignedTaskTableData(
      {@required this.id,
      @required this.taskId,
      @required this.groupId,
      @required this.userId,
      @required this.isDone,
      @required this.isSync});
  factory AssignedTaskTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return AssignedTaskTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      taskId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}task_id']),
      groupId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}group_id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
      isSync:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_sync']),
    );
  }
  factory AssignedTaskTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return AssignedTaskTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      groupId: serializer.fromJson<String>(json['groupId']),
      userId: serializer.fromJson<String>(json['userId']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      isSync: serializer.fromJson<bool>(json['isSync']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'groupId': serializer.toJson<String>(groupId),
      'userId': serializer.toJson<String>(userId),
      'isDone': serializer.toJson<bool>(isDone),
      'isSync': serializer.toJson<bool>(isSync),
    };
  }

  @override
  AssignedTaskTableCompanion createCompanion(bool nullToAbsent) {
    return AssignedTaskTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      isSync:
          isSync == null && nullToAbsent ? const Value.absent() : Value(isSync),
    );
  }

  AssignedTaskTableData copyWith(
          {String id,
          String taskId,
          String groupId,
          String userId,
          bool isDone,
          bool isSync}) =>
      AssignedTaskTableData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        groupId: groupId ?? this.groupId,
        userId: userId ?? this.userId,
        isDone: isDone ?? this.isDone,
        isSync: isSync ?? this.isSync,
      );
  @override
  String toString() {
    return (StringBuffer('AssignedTaskTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId, ')
          ..write('isDone: $isDone, ')
          ..write('isSync: $isSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          taskId.hashCode,
          $mrjc(
              groupId.hashCode,
              $mrjc(
                  userId.hashCode, $mrjc(isDone.hashCode, isSync.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is AssignedTaskTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.groupId == this.groupId &&
          other.userId == this.userId &&
          other.isDone == this.isDone &&
          other.isSync == this.isSync);
}

class AssignedTaskTableCompanion
    extends UpdateCompanion<AssignedTaskTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> groupId;
  final Value<String> userId;
  final Value<bool> isDone;
  final Value<bool> isSync;
  const AssignedTaskTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.userId = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isSync = const Value.absent(),
  });
  AssignedTaskTableCompanion.insert({
    @required String id,
    @required String taskId,
    @required String groupId,
    @required String userId,
    @required bool isDone,
    this.isSync = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        groupId = Value(groupId),
        userId = Value(userId),
        isDone = Value(isDone);
  AssignedTaskTableCompanion copyWith(
      {Value<String> id,
      Value<String> taskId,
      Value<String> groupId,
      Value<String> userId,
      Value<bool> isDone,
      Value<bool> isSync}) {
    return AssignedTaskTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      isDone: isDone ?? this.isDone,
      isSync: isSync ?? this.isSync,
    );
  }
}

class $AssignedTaskTableTable extends AssignedTaskTable
    with TableInfo<$AssignedTaskTableTable, AssignedTaskTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AssignedTaskTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  GeneratedTextColumn _taskId;
  @override
  GeneratedTextColumn get taskId => _taskId ??= _constructTaskId();
  GeneratedTextColumn _constructTaskId() {
    return GeneratedTextColumn(
      'task_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _groupIdMeta = const VerificationMeta('groupId');
  GeneratedTextColumn _groupId;
  @override
  GeneratedTextColumn get groupId => _groupId ??= _constructGroupId();
  GeneratedTextColumn _constructGroupId() {
    return GeneratedTextColumn(
      'group_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn(
      'is_done',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isSyncMeta = const VerificationMeta('isSync');
  GeneratedBoolColumn _isSync;
  @override
  GeneratedBoolColumn get isSync => _isSync ??= _constructIsSync();
  GeneratedBoolColumn _constructIsSync() {
    return GeneratedBoolColumn('is_sync', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, groupId, userId, isDone, isSync];
  @override
  $AssignedTaskTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'assigned_task_table';
  @override
  final String actualTableName = 'assigned_task_table';
  @override
  VerificationContext validateIntegrity(AssignedTaskTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.taskId.present) {
      context.handle(
          _taskIdMeta, taskId.isAcceptableValue(d.taskId.value, _taskIdMeta));
    } else if (taskId.isRequired && isInserting) {
      context.missing(_taskIdMeta);
    }
    if (d.groupId.present) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableValue(d.groupId.value, _groupIdMeta));
    } else if (groupId.isRequired && isInserting) {
      context.missing(_groupIdMeta);
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (userId.isRequired && isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.isDone.present) {
      context.handle(
          _isDoneMeta, isDone.isAcceptableValue(d.isDone.value, _isDoneMeta));
    } else if (isDone.isRequired && isInserting) {
      context.missing(_isDoneMeta);
    }
    if (d.isSync.present) {
      context.handle(
          _isSyncMeta, isSync.isAcceptableValue(d.isSync.value, _isSyncMeta));
    } else if (isSync.isRequired && isInserting) {
      context.missing(_isSyncMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssignedTaskTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AssignedTaskTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AssignedTaskTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.taskId.present) {
      map['task_id'] = Variable<String, StringType>(d.taskId.value);
    }
    if (d.groupId.present) {
      map['group_id'] = Variable<String, StringType>(d.groupId.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    if (d.isDone.present) {
      map['is_done'] = Variable<bool, BoolType>(d.isDone.value);
    }
    if (d.isSync.present) {
      map['is_sync'] = Variable<bool, BoolType>(d.isSync.value);
    }
    return map;
  }

  @override
  $AssignedTaskTableTable createAlias(String alias) {
    return $AssignedTaskTableTable(_db, alias);
  }
}

abstract class _$TwixDB extends GeneratedDatabase {
  _$TwixDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $BoardTableTable _boardTable;
  $BoardTableTable get boardTable => _boardTable ??= $BoardTableTable(this);
  $GroupTableTable _groupTable;
  $GroupTableTable get groupTable => _groupTable ??= $GroupTableTable(this);
  $TaskTableTable _taskTable;
  $TaskTableTable get taskTable => _taskTable ??= $TaskTableTable(this);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  $GroupUserTableTable _groupUserTable;
  $GroupUserTableTable get groupUserTable =>
      _groupUserTable ??= $GroupUserTableTable(this);
  $AssignedTaskTableTable _assignedTaskTable;
  $AssignedTaskTableTable get assignedTaskTable =>
      _assignedTaskTable ??= $AssignedTaskTableTable(this);
  BoardDao _boardDao;
  BoardDao get boardDao => _boardDao ??= BoardDao(this as TwixDB);
  GroupDao _groupDao;
  GroupDao get groupDao => _groupDao ??= GroupDao(this as TwixDB);
  TaskDao _taskDao;
  TaskDao get taskDao => _taskDao ??= TaskDao(this as TwixDB);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as TwixDB);
  GroupUserDao _groupUserDao;
  GroupUserDao get groupUserDao =>
      _groupUserDao ??= GroupUserDao(this as TwixDB);
  AssignedTaskDao _assignedTaskDao;
  AssignedTaskDao get assignedTaskDao =>
      _assignedTaskDao ??= AssignedTaskDao(this as TwixDB);
  @override
  List<TableInfo> get allTables => [
        boardTable,
        groupTable,
        taskTable,
        userTable,
        groupUserTable,
        assignedTaskTable
      ];
}
