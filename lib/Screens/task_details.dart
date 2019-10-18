import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Database/DAOs/task_dao.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskWithBoard task;

  TaskDetailsScreen({this.task});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.board.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Created five minutes ago'),
                    )),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Icon(Icons.delete_outline),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 100,
            child: Card(
              margin: EdgeInsets.zero,
              child: Center(
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text(task.task.name),
                  trailing: database.taskDao.isMyDay(task.task.myDayDate)
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add_alert),
                  title: Text('Remind Me'),
                ),
                Divider(
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Add due date'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add note'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
