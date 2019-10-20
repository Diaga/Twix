import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

class NoteEditor extends StatelessWidget {
  final TaskWithBoard task;
  final TextEditingController notesController = TextEditingController();

  NoteEditor({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: ThemeData
            .light()
            .scaffoldBackgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check),onPressed: (){
            String notes = '';
            if (notesController.text.isNotEmpty) {
              notes = notesController.text;
            }
            database.taskDao.updateTask(task.task.copyWith(
                notes: notes
            ));
            Navigator.pop(context);
          },)
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            controller: notesController,
          ),
        ),
      ),
    );
  }
}
