import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

void main() async {
  runApp(Twix());
}

class Twix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
