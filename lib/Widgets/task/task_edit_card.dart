import 'package:flutter/material.dart';

class TaskEditCard extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function callBack;

  TaskEditCard({Key key, this.textEditingController,
    this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListTile(
        leading: Container(
          width: size.width * 0.7,
          child: TextField(
            controller: textEditingController,
            decoration: null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.check),
          onPressed: callBack,
        ),
      ),
    );
  }
}
