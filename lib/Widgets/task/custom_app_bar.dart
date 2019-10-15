import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  final Color color;

  CustomAppBar({this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: height,
          color: color,
          child: Row(
            children: <Widget>[
              Expanded(child: CircleAvatar()),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        'xyz@gmail.com',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
