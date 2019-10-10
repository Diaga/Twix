import 'package:flutter/material.dart';

class TaskTable {
  int id;
  String name;
  int isDone;
  int boardId;

  bool get getIsDone => isDone == 1;

  set setIsDone(bool val) {
    if (val) isDone = 1;
    else isDone = 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'name': name,
      'isDone': isDone,
      'boardId': boardId
    };
  }

  TaskTable({@required this.name, this.isDone = 0, @required this.boardId});

  TaskTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isDone = map['isDone'];
    boardId = map['boardId'];
  }
}
