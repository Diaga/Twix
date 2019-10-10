import 'package:flutter/material.dart';

import 'package:twix/Widgets/board/board.dart';

class BoardTable {
  int id;
  String name;
  int isPersonal;

  bool get getIsPersonal => isPersonal == 1;

  set setIsPersonal(bool val) {
    if (val) isPersonal = 1;
    else isPersonal = 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'name': name,
      'isPersonal': isPersonal
    };
  }

  BoardTable({@required this.name, this.isPersonal = 1});

  BoardTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isPersonal = map['isPersonal'];
  }
}
