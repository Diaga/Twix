import 'package:flutter/material.dart';
import 'package:twix/Screens/board_screen.dart';

import 'package:twix/Screens/task_screen.dart';
import 'package:twix/Widgets/board/board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TaskScreen(),
      ),
    );
  }
}
