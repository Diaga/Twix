import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:twix/Database/database.dart';

import 'package:twix/Screens/home_screen.dart';

import 'Screens/login_screen.dart';

void main() async {
  runApp(Twix());
}

class Twix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        builder: (_) => TwixDB(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Login(),
          ),
        ));
  }
}