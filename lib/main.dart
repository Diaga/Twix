import 'package:flutter/material.dart';

import 'package:twix/Screens/board_screen.dart';
import 'package:twix/Screens/task_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF3C6AFF),
      ),
      home: Scaffold(
        body: BoardScreen(),
      ),
    );
  }
}
