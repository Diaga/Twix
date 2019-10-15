import 'package:flutter/material.dart';

class BoardsList extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function callBack;

  BoardsList({this.iconData, this.title, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: ListTile(
        leading: Icon(iconData),
        title: Text(title),
        onTap: callBack,
      ),
    );
  }
}
