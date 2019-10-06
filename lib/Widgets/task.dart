import 'package:flutter/material.dart';


class Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white70,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100], offset: Offset(3, 3), blurRadius: 5),
          ]),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline),
        title: Text('Tasks'),
      ),
    );
  }
}