import 'package:flutter/material.dart';
import 'package:twix/Screens/task_screen.dart';
import 'package:twix/Widgets/task/board_list.dart';
import 'package:twix/Widgets/task/custom_app_bar.dart';
import 'package:twix/Widgets/task/custom_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 80.0, color: ThemeData.light().scaffoldBackgroundColor),
      bottomNavigationBar: CustomBottomBar(
        listCallBack: () {},
        groupCallBack: () {},
      ),
      body: ListView(
        children: <Widget>[
          BoardsList(
              iconData: Icons.wb_sunny,
              title: 'My Day',
              callBack: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskScreen(
                              action: 'My Day',
                            )));
              }),
          BoardsList(
              iconData: Icons.person_outline,
              title: 'Assigned To Me',
              callBack: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskScreen()));
              }),
          BoardsList(
            iconData: Icons.playlist_add_check,
            title: 'My Tasks',
            callBack: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskScreen(
                            action: 'My Tasks',
                          )));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
