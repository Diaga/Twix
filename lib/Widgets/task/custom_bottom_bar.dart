import 'package:flutter/material.dart';


class CustomBottomBar extends StatelessWidget {
  final Function listCallBack;
  final Function groupCallBack;

  CustomBottomBar({this.listCallBack, this.groupCallBack});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ThemeData.light().scaffoldBackgroundColor,
      elevation: 0,
      child: Container(
        height: 56,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: InkWell(
                onTap: listCallBack,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(
                        Icons.add,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('New List'),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.group), onPressed: groupCallBack)
          ],
        ),
      ),
    );
  }
}
