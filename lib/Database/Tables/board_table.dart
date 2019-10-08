import 'package:twix/Widgets/board/board.dart';

class BoardTable {
  int id;
  String name;
  bool isPersonal;

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'name': name,
      'isPersonal': isPersonal
    };
  }

  BoardTable({this.name, this.isPersonal = true});

  BoardTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isPersonal = map['isPersonal'];
  }
}
