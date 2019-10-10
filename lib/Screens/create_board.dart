import 'package:flutter/material.dart';
import 'package:twix/Database/Tables/board_table.dart';
import 'package:twix/Palette/palette.dart';
class CreateBoard extends StatefulWidget {
  @override
  _CreateBoardState createState() => _CreateBoardState();
}

class _CreateBoardState extends State<CreateBoard> {
  bool personalChecker = false;
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting up Board',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Board Name',
                ),
                onChanged: (value){
                  title = value;
                },
              ),
            ),
            CheckboxListTile(
              value: personalChecker,
              title: Text('Personal Board'),
              onChanged: (bool value) {
                setState(() {
                  personalChecker = value;
                });
              },
            ),
            CheckboxListTile(
              value: false,
              title: Text('Group Board'),
              onChanged: (bool value) {},
            ),
            SizedBox(height: 50,),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.92,
              height:45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context,BoardTable(name: title,isPersonal: personalChecker ? 1 : 0));
                },
                color: Palette.primaryColor,
                elevation: 3,
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
