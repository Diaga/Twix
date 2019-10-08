import 'package:flutter/material.dart';


class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  'Title',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                subtitle: Text(
                  'Submit a project',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
