import 'package:flutter/material.dart';
import 'Screens/login.dart';

void main() async {
  runApp(Twix());
}

class Twix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF3C6AFF),
      ),
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}
