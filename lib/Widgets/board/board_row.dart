import 'package:flutter/material.dart';

class BoardRow extends StatelessWidget {
  final List<Widget> widgets;

  BoardRow({Key key, this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
