class TaskTable {
  int id;
  String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'name': name
    };
  }

  TaskTable({this.name});

  TaskTable.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
